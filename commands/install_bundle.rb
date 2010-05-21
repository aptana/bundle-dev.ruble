require 'ruble'
require 'ruble/project'
require 'fileutils'

RubleInfo = Struct.new(:display_name, :directory_name, :repository)

INSTALLABLE_RUBLES = [
  RubleInfo.new("GitHub",        "github",       "git://github.com/aptana/github.ruble.git"),
  RubleInfo.new("Shell Script",  "shell-script", "git://github.com/aptana/shell-script.ruble.git"),
  RubleInfo.new("WebFont",       "WebFont",      "git://github.com/aptana/WebFont.ruble.git")
]

# This asks the user which of the known bundles they would like to install
command "Install Bundle" do |cmd|
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.invoke do |context|
    # Ask user which of the pre-installed bundles to grab!
    options = {}
    options[:items] = INSTALLABLE_RUBLES.map {|bundle| bundle.display_name }
    chosen = Ruble::UI.request_item(options)
    context.exit_show_tooltip("No bundle selected") if chosen.nil?
      
    ruble_info = INSTALLABLE_RUBLES.select {|ruble_info| ruble_info.display_name == chosen}.first
    context.exit_discard if ruble_info.nil?
      
    bundles_dir = Ruble::BundleManager.manager.user_bundles_path
    FileUtils.makedirs(bundles_dir)

    Dir.chdir(bundles_dir)
    # If Ruble already exists, we should punt
    if File.exists?(ruble_info.directory_name)
      "Directory already exists, did not grab bundle"
    else        
      str = ""
      # TODO determine git/svn by looking at the URL?
      IO.popen("git clone #{ruble_info.repository} #{ruble_info.directory_name}", 'r') {|io| str << io.read }
      # Also generate a project for the bundle and add it in the workspace?
      proj = Ruble::Project.create( ruble_info.display_name,
                                    :location => File.join(bundles_dir, ruble_info.directory_name))
      proj.open
      str
    end
  end
end