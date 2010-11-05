require 'ruble'
require 'ruble/platform'

bundle do |bundle|
  bundle.author = "Christopher Williams, Andrew Shebanow"
  bundle.copyright = "(C) Copyright 2010 Aptana Inc. Distributed under the MIT license."
  bundle.display_name = 'Bundle Development'
  bundle.description = "A quick and dirty bundle to make it easier to update your other bundles."
  bundle.repository = "git://github.com/aptana/bundle-dev.ruble.git"

  # This command should show regardless of scope, so we don't define one.
  bundle.menu "Bundle Development" do |menu|
    menu.command "Show Scope"
    menu.command "Copy Scope"
    menu.separator
    menu.command "Show ENV"
    menu.separator
    menu.command "Install Bundle"
    menu.command "Update User Bundles"
    menu.command "Convert TextMate Bundle" if Ruble.is_mac?
    menu.separator
    menu.command "Show Command Bindings"
    menu.command "Show Active Commands in Scope"
    menu.command "Show Active Snippets in Scope"
  end
  
end

