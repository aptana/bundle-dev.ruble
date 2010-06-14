require 'ruble'
require 'ruble/project'
require 'fileutils'

# HEY! Want your Ruble included here? Send us a pull request on github!
RubleInfo = Struct.new(:display_name, :directory_name, :repository)
INSTALLABLE_RUBLES = [
  RubleInfo.new("GitHub",        "github.ruble",       "git://github.com/aptana/github.ruble.git"),
  RubleInfo.new("Shell Script",  "shell-script.ruble", "git://github.com/aptana/shell-script.ruble.git"),
  RubleInfo.new("WebFont",       "WebFont.ruble",      "git://github.com/aptana/WebFont.ruble.git")
]

# This asks the user which of the known bundles they would like to install
command "Install Bundle" do |cmd|
  cmd.input = :none
  cmd.output = :none
  cmd.invoke do |context|
    # Ask user which of the pre-installed bundles to grab!
    bundles_dir = Ruble::BundleManager.manager.user_bundles_path
    app_bundles_dir = Ruble::BundleManager.manager.application_bundles_path

    options = {}
    items = []
    INSTALLABLE_RUBLES.each do |bundle| 
      if !File.exists?(File.join(app_bundles_dir, bundle.directory_name)) && !File.exists?(File.join(bundles_dir, bundle.directory_name))
        items << bundle.display_name 
      end
    end
    
    options[:items] = items
    if items.length == 1
      options[:button1]= "Install"
      options[:title] = "Install Bundle"
      options[:prompt] = "Install #{items.first} Bundle?"
      Ruble::UI.request_confirmation(options) ? chosen = items.first : chosen = nil
    elsif items.length == 0
      context.exit_show_tool_tip("There are no bundles to install.")
    else
      options[:title] = "Select Bundle to Install"
      chosen = Ruble::UI.request_item(options)
    end
    context.exit_show_tool_tip("No Bundle selected") if chosen.nil?
      
    ruble_info = INSTALLABLE_RUBLES.select {|ruble_info| ruble_info.display_name == chosen}.first
    
    # TODO determine git/svn by looking at the URL?
    
    # IO.popen("git clone #{ruble_info.repository} #{ruble_info.directory_name}", 'r') {|io| str << io.read }
    Ruble::Terminal.open("git clone #{ruble_info.repository}", bundles_dir)
  
    # Also generate a project for the bundle and add it in the workspace?
    # proj = Ruble::Project.create( ruble_info.display_name,
                                  # :location => File.join(bundles_dir, ruble_info.directory_name))
    # proj.open
    
  end
end