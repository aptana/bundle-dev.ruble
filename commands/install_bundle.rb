require 'ruble'
#require 'ruble/project'

# HEY! Want your Ruble included here? Send us a pull request on github!
RubleInfo = Struct.new(:display_name, :directory_name, :repository) unless defined?(RubleInfo)
INSTALLABLE_RUBLES = [
  RubleInfo.new("Boxee",            "boxee.ruble",               "git://github.com/sgtcoolguy/boxee.ruble.git"),
  RubleInfo.new("Bundler",          "bundler.ruble",             "git://github.com/aptana/bundler.ruble.git"),
  RubleInfo.new("Drupal",           "Drupal.ruble",              "git://github.com/arcaneadam/Drupal-Bundle-for-Aptana.git"),
  RubleInfo.new("GitHub",           "github.ruble",              "git://github.com/aptana/github.ruble.git"),
  RubleInfo.new("jQuery",           "javascript-jquery.ruble",   "git://github.com/aptana/javascript-jquery.ruble.git"),  
  RubleInfo.new("Mercurial",        "mercurial.ruble",           "git://github.com/aptana/mercurial.ruble.git"),
  RubleInfo.new("Play Framework",   "play.ruble",                "git://github.com/garbagetown/play.ruble.git"),
  RubleInfo.new("RSense",           "rsense.ruble",              "git://github.com/aptana/rsense.ruble.git"),
  RubleInfo.new("Scaffold",         "Scaffold.ruble",            "git://github.com/brianegan/Scaffold.ruble.git"),
  RubleInfo.new("Shell Script",     "shell-script.ruble",        "git://github.com/aptana/shell-script.ruble.git"),
  RubleInfo.new("Titanium Desktop", "titanium_desktop.ruble",    "git://github.com/appcelerator/titanium_desktop.ruble.git"),
  RubleInfo.new("Titanium Mobile",  "titanium_mobile.ruble",     "git://github.com/appcelerator/titanium_mobile.ruble.git"),
  RubleInfo.new("WebFont",          "WebFont.ruble",             "git://github.com/aptana/WebFont.ruble.git"),
  RubleInfo.new("Wordpress",        "Wordpress.ruble",           "git://github.com/aptana/wordpress.ruble.git"),
  RubleInfo.new("Zen Coding",       "zen-coding.ruble",          "git://github.com/aptana/zen-coding.ruble.git")
] unless defined?(INSTALLABLE_RUBLES)

# This asks the user which of the known bundles they would like to install
command t(:install_bundle) do |cmd|
  cmd.input = :none
  cmd.output = :none
  cmd.invoke do |context|
    manager = Ruble::BundleManager.manager
    
    # pre-filter out any bundles already installed
    uninstalled_rubles = INSTALLABLE_RUBLES.select {|r| manager.getBundleEntry(r.display_name).nil? }.map {|r| r.display_name }
    uninstalled_rubles.sort! # sort alphabetically
    
    # Ask user which of the bundles to grab!
    options = {}
    options[:items] = uninstalled_rubles
    if uninstalled_rubles.length == 1
      options[:button1]= "Install"
      options[:title] = "Install Bundle"
      options[:prompt] = "Install #{items.first} Bundle?"
      chosen = Ruble::UI.request_confirmation(options) ? uninstalled_rubles.first : nil
    elsif uninstalled_rubles.length == 0
      context.exit_show_tool_tip("There are no bundles to install.")
    else
      options[:title] = "Select Bundle to Install"
      chosen = Ruble::UI.request_item(options)
    end
    context.exit_show_tool_tip("No Bundle selected") if chosen.nil?
      
    chosen_ruble = INSTALLABLE_RUBLES.select {|r| r.display_name == chosen}.first
    
    # TODO determine git/svn by looking at the URL?
    
    # IO.popen("git clone #{chosen_ruble.repository} #{chosen_ruble.directory_name}", 'r') {|io| str << io.read }
    Ruble::Terminal.open("git clone #{chosen_ruble.repository}", manager.user_bundles_path)
  
    # Also generate a project for the bundle and add it in the workspace?
    # proj = Ruble::Project.create( chosen_ruble.display_name, :location => File.join(manager.user_bundles_path, chosen_ruble.directory_name))
    # proj.open
    
  end
end
