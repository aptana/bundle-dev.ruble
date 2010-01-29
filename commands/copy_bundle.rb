require 'ruble'
require 'ruble/project'
require 'fileutils'

# This asks the user which of the pre-installed bundles with a known repository they'd liek to grab.
# This will then do a git clone of the bundle and create a project for this copy.
command "Grab Bundle" do |cmd|
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.invoke do |context|
    bundle_manager = Ruble::BundleManager.manager
    app_bundles = bundle_manager.application_bundles.select {|bundle| !bundle.repository.nil? }
    context.exit_show_tooltip("No bundles to select from") if app_bundles.empty?
      
    # Ask user which of the pre-installed bundles to grab!
    options = {}
    options[:items] = app_bundles.map {|bundle| bundle.display_name }
    chosen = Ruble::UI.request_item(options)
    context.exit_show_tooltip("No bundle selected") if chosen.nil?
      
    bundle = app_bundles.select {|bundle| bundle.display_name == chosen}.first
    context.exit_discard if bundle.nil?
      
    repo_url = bundle.repository      
    dir_name = bundle.display_name.gsub(/[\s\-]+/, '_').downcase + ".ruble"
    bundles_dir = bundle_manager.getUserBundlesPath
    FileUtils.makedirs(bundles_dir)
    Dir.chdir(bundles_dir)  # Go to bundles root dir
    # TODO determine git/svn by looking at the URL?
    str = ""
    IO.popen("git clone #{repo_url} #{dir_name}", 'r') {|io| str << io.read }
    # Also generate a project for the bundle and add it in the workspace?
    proj = Ruble::Project.create(bundle.display_name, :location => File.join(bundles_dir, dir_name))
    proj.open
    str
  end
end