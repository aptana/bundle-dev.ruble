require 'ruble'
require 'ruble/platform'

bundle do |bundle|
  bundle.author = "Christopher Williams, Andrew Shebanow"
  bundle.copyright = '(C) Copyright 2010 Aptana Inc. Distributed under the MIT license.'
  bundle.display_name = 'Bundle Development'
  bundle.description = "A bundle to help develop your own bundles, grab 3rd-party bundles, convert Textnate bundles, and see scope/theme information."
  bundle.repository = 'git://github.com/aptana/bundle-dev.ruble.git'

  # This command should show regardless of scope, so we don't define one.
  bundle.menu "Bundle Development" do |menu|
    menu.command "Show Scope"
    menu.command "Copy Scope"
    menu.command "Show Scope and Matching Theme Rule"
    menu.separator
    menu.command "Show ENV"
    menu.separator
    menu.command "Install Bundle"
    menu.command "Update User Bundles"
    menu.command "Flush Bundle Caches"
    menu.separator
    menu.command "Show Command Bindings"
    menu.command "Show Active Commands in Scope"
    menu.command "Show Active Snippets in Scope"
    menu.separator
    menu.menu "Insert Bundle Section" do |ruble_menu|
        ruble_menu.command 'Bundle.rb'
        ruble_menu.separator
        ruble_menu.command 'Menu Command'
        ruble_menu.command 'Menu Separator'
        ruble_menu.command 'Menu Block'
        ruble_menu.separator
        ruble_menu.command 'Command'
        ruble_menu.command 'Snippet'
        ruble_menu.separator
        ruble_menu.command 'Content Assist Block'
        ruble_menu.command 'With Defaults Block'
        ruble_menu.command 'Environment'
        ruble_menu.command 'Smart Typing Pairs Definition'
        ruble_menu.separator
        ruble_menu.command 'File Template'
        ruble_menu.command 'Project Template'
    end
    menu.command "Convert TextMate Bundle" if Ruble.is_mac?
  end
end
