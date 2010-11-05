require 'ruble'

command 'Show Active Snippets in Scope' do |cmd|
  cmd.output = :create_new_document
  cmd.scope = :all
  cmd.invoke do |context|
    scope_filter = com.aptana.scripting.model.filters.ScopeFilter.new(ENV['TM_SCOPE'])
    filter = com.aptana.scripting.model.filters.AndFilter.new(scope_filter, com.aptana.scripting.model.filters.HasTriggerFilter.new)
  
    commands = Ruble::BundleManager.manager.getCommands(filter)
    
    by_triggers = {}
    commands.each do |c|
      triggers = c.triggers
      next if triggers.length == 0
      triggers.each do |t|
        existing = by_triggers[t] || []
        existing << c.display_name
        by_triggers[t] = existing
      end
    end
    # Sort by the triggers
    by_triggers.sort.each {|k, v| puts "#{k}: #{v.join(', ')}"}
    nil
  end
end