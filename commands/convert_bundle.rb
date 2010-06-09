require 'ruble'
require 'ruble/project'

command "Convert Textmate Bundle" do |cmd|
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.invoke do |context|
    # Find where rubles are stored
    bundles_dir = Ruble::BundleManager.manager.user_bundles_path
    FileUtils.makedirs(bundles_dir)
    
    # Open a dialog asking for location of textmate bundle
    bundle_to_convert_path = Ruble::UI.request_file(:only_directories => false, :title => 'Select bundle to convert', :directory => '~/Library/Application Support/TextMate/Bundles')
    
    #FIXME exit_show_tooltip does not seem to work
    #context.exit_show_tooltip("No bundle selected") if bundle_to_convert_path.nil? || bundle_to_convert_path.empty?
    
    if bundle_to_convert_path.nil? || bundle_to_convert_path.empty?
      "No bundle selected"
    else    
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
      
      "Please note that this bundle conversion process is really meant as a starting point for converting bundles over to rubles.\nNearly every bundle will need additional work, and often many commands will work better or require less code if converted from shell scripts to in-process ruby (block invocation).\nSee https://radrails.tenderapp.com/faqs/radrails-3/ruble-programming-guide"
    end
  end
end