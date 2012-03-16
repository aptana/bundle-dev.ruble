require 'ruble'

command t(:validate_snippets) do |cmd|
  cmd.input = :none
  cmd.output = :create_new_document
  cmd.invoke do
    # Grab every snippet or command that acts like a snippet
    bm = com.aptana.scripting.model.BundleManager.getInstance
    snippets = bm.getExecutableCommands(com.aptana.scripting.model.filters.HasTriggerFilter.new)
    
    # Generate templates for each one
    contextTypeId = ""
    templatesList = {}
    snippets.each do |snip|
      triggers = snip.getTriggerTypeValues(com.aptana.scripting.model.TriggerType::PREFIX)
      triggers.each do |trigger|
        template = nil
        if snip.java_kind_of? com.aptana.scripting.model.SnippetElement
          template = com.aptana.editor.common.scripting.snippets.SnippetTemplate.new(snip, trigger, contextTypeId)
        else
          template = com.aptana.editor.common.scripting.snippets.CommandTemplate.new(snip, trigger, contextTypeId)
        end
        templatesList[template] = snip.getOwningBundle.getPath
      end
    end
    
    # Now verify every template. generate a map from bundle path to list of failed snippet names
    failures = {}
    st = com.aptana.editor.common.scripting.snippets.SnippetTemplateTranslator.new
    templatesList.each do |template, bundle_path|
      begin
        st.translate(template)
      rescue
        # If we get a TemplateException, template is busted.
        snips = failures[bundle_path]
        snips = [] unless snips
        snips << template.description
        failures[bundle_path] = snips
      end
    end
    
    # Spit out failures
    if failures.size > 0
      puts t(:snippets_failed_validation)
      failures.each do |bundle_path, fails|
        puts t(:bundle_0, :bundle_path => bundle_path)
        puts "  #{fails.join("\n  ")}\n\n"
      end
    else
      puts t(:no_snippets_failed_validation)
    end
    nil
  end
end

