require 'ruble'

# Show the rule which 'won' to color this token
command t(:show_scope_and_theme_rule) do |cmd|
  cmd.key_binding = "M1+M3+P"
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.invoke do
    scope = ENV['TM_SCOPE']
    
    theme_manager = com.aptana.theme.ThemePlugin.getDefault.getThemeManager
    theme = theme_manager.getCurrentTheme()
    
    rules = theme.tokens.select {|rule| !rule.isSeparator }
    selectors = rules.map {|rule| rule.getScopeSelector }
    matching_selector = com.aptana.scope.ScopeSelector.bestMatch(selectors, scope)
    matching_rule = rules.find {|rule| rule.getScopeSelector.equals(matching_selector) }
    
    "Scope: #{scope}\nRule: #{matching_rule.to_s}"
  end
end

