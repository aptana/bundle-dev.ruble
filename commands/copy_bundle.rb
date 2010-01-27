require 'radrails'
require 'radrails/ui'

command "Grab Bundle" do |cmd|
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.invoke do |context|
    bundle_manager = RadRails::BundleManager.manager
    bundles_dir = bundle_manager.getUserBundlesPath

    # Ask user which of the pre-installed bundles to grab!
    options = {}
    options[:items] = bundle_manager.application_bundles.map {|bundle| bundle.display_name }
    chosen = RadRails::UI.request_item(options)
    context.exit_show_tooltip("No bundles to select from") if chosen.nil?
      
    bundle = bundle_manager.application_bundles.select {|bundle| bundle.display_name == chosen}.first
    repo_url = bundle.repository
    context.exit_show_tooltip("Selected bundle has no repository URL defined") if repo_url.nil?
      
    dir_name = bundle.display_name.gsub(/[\s\-]+/, '_') + ".ruble"
    # TODO determine git/svn by looking at the URL?
    str = ""
    File.makedirs(bundles_dir)
    Dir.chdir(bundles_dir)  # Go to bundles root dir
    IO.popen("git clone #{repo_url} #{dir_name}", 'r') {|io| str << io.read } # FIXME check exit value?
    str
  end
end