require 'ruble'
require 'ruble/platform'

bundle do |bundle|
  bundle.author = "Christopher Williams, Andrew Shebanow"
  bundle.copyright = '(C) Copyright 2011 Appcelerator Inc. Distributed under the MIT license.'
  bundle.display_name = 'Bundle Development'
  bundle.description = "A bundle to help develop your own bundles, grab 3rd-party bundles, convert TextMate bundles, and see scope/theme information."
  bundle.repository = 'git://github.com/aptana/bundle-dev.ruble.git'

  # This command should show regardless of scope, so we don't define one.
  bundle.menu t(:toplevel_menu) do |menu|
    menu.command t(:show_scope)
    menu.command t(:copy_scope)
    menu.command t(:show_scope_and_theme_rule)
    menu.separator
    menu.command t(:show_env)
    menu.separator
    menu.command t(:install_bundle)
    menu.command t(:update_bundles)
    menu.command t(:flush_caches)
    menu.separator
    menu.command t(:show_bindings)
    menu.command t(:show_active_commands)
    menu.command t(:show_active_snippets)
    menu.separator
    menu.menu t(:insert_bundle_section) do |ruble_menu|
        ruble_menu.command t(:bundle_rb)
        ruble_menu.separator
        ruble_menu.command t(:menu_command)
        ruble_menu.command t(:menu_separator)
        ruble_menu.command t(:menu_block)
        ruble_menu.separator
        ruble_menu.command t(:command)
        ruble_menu.command t(:snippet)
        ruble_menu.separator
        ruble_menu.command t(:content_assist)
        ruble_menu.command t(:with_defaults)
        ruble_menu.command t(:environment)
        ruble_menu.command t(:smart_typing_pairs)
        ruble_menu.separator
        ruble_menu.command t(:file_template)
        ruble_menu.command t(:project_template)
    end
    menu.separator
    menu.command t(:validate_snippets)
    menu.command t(:convert_bundle) if Ruble.is_mac?
  end
end
