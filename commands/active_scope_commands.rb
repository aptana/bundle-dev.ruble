require 'ruble'

command t(:show_active_commands) do |cmd|
  cmd.output = :create_new_document
  cmd.scope = :all
  cmd.invoke do |context|
    filter = com.aptana.scripting.model.filters.ScopeFilter.new(ENV['TM_SCOPE'])
    commands = Ruble::BundleManager.manager.getCommands(filter)
    
    by_bindings = {}
    commands.each do |c|
      bindings = c.key_bindings
      next if bindings.length == 0
      bindings.each do |b|
        # TODO Convert M1-M4 to CTRL/ALT/OPTION/etc to normalize them
        existing = by_bindings[b] || []
        existing << c.display_name
        by_bindings[b] = existing
      end
    end
    # Sort by the bindings?
    by_bindings.sort.each {|k, v| puts "#{k}: #{v.join(', ')}"}
    nil
  end
end