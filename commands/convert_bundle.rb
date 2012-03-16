require 'ruble'
require 'ruble/project'
require 'ruble/platform'

if Ruble.is_mac?
  command t(:convert_bundle) do |cmd|
    cmd.input = :none
    cmd.output = :show_as_tooltip
    cmd.invoke do |context|
      require 'fileutils'
      # Find where rubles are stored
      bundles_dir = Ruble::BundleManager.manager.user_bundles_path
      FileUtils.makedirs(bundles_dir)
      
      # Open a dialog asking for location of textmate bundle
      bundle_to_convert_path = Ruble::UI.request_file(:only_directories => false, :title => t(:select_bundle_to_convert), :directory => '~/Library/Application Support/TextMate/Bundles')
      
      context.exit_show_tool_tip(t(:no_bundle_selected)) if bundle_to_convert_path.nil? || bundle_to_convert_path.empty?
          
      # Now set up variables to choose input/output
      bundle_to_convert = java.io.File.new(bundle_to_convert_path)
      base_name = bundle_to_convert.name.end_with?('tmbundle') ? bundle_to_convert.name[0...-9] : bundle_to_convert.name
      Ruble::Logger.log_error base_name
      converted_bundle_path = File.join(bundles_dir, "#{base_name}.ruble")
      # OK, convert!
      com.aptana.scripting.BundleConverter.convertBundle(bundle_to_convert, converted_bundle_path)
        
      # Also generate a project for the bundle and add it in the workspace?
      proj = Ruble::Project.create(base_name, :location => converted_bundle_path)
      proj.open
      
      t(:bundle_convert_msg)
    end
  end
end