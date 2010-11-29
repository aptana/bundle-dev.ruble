require 'ruble'

with_defaults :scope => 'source.ruby' do

  # Snippet to generate a snippet
  snippet 'snippet' do |s|
    s.trigger = 'sn'
    s.expansion = 
"snippet '${1:name}' do |s|
  s.trigger = '${2:trigger}'
  s.scope = '${3:source.ruby}'
  s.expansion = \"${4:example}\"
end"
  end

  # Snippet to repeatedly insert menu command items
  snippet 'm.command' do |s|
    s.trigger = 'm.'
    s.expansion = "m.command '${1:command_or_snippet_name}'
m.$0"
  end

  # Insert a menu separator
  snippet 'm.separator' do |s|
    s.trigger = 'm.'
    s.expansion = "m.separator
m.$0"
  end

# Generate a sub-menu
  snippet 'm.menu' do |s|
    s.trigger = 'm.'
    s.expansion = "m.menu '${1:submenu}' do |m|
  m.$0
end"
  end

  # Snippet to generate a command
  snippet 'command' do |s|
    s.trigger = 'co'
    s.expansion = 
"require 'ruble'

command '${1:name}' do |cmd|
  cmd.input = :${2:none/document/selection/word/right_character/left_character/line/clipboard/selected_lines}
  cmd.output = :${3:discard/show_as_tooltip/replace_selection/replace_line/replace_word/show_as_html/insert_as_text/insert_as_snippet/create_new_document}
  cmd.key_binding = '${4:CONTROL+SHIFT+E}'
  cmd.scope = '${5:source.ruby}'
  cmd.invoke do |context|
    # Write your ruby code here. If there's a non-nil return value for the block that will be used as output/result value.
    # Otherwise we'll take what was piped to STDOUT
    nil
  end
end"  
  end
  
  # Snippet to generate a bundle
  command 'bundle' do |s|
    s.trigger = 'bu'
    s.input = :none
    s.output = :insert_as_snippet
    s.invoke do
      org = ENV["TM_ORGANIZATION_NAME"] || 'Example.org'
      full_name = ENV['TM_FULLNAME'] || ENV['USER'] || "John Doe"
      user = ENV['USER'] || 'user'
"require 'ruble'

bundle '${1:Bundle name}' do |bundle|
  bundle.author = '${2:#{full_name}}'
  bundle.copyright = <<END
(c) Copyright #{Time.now.year} ${3:#{org}}. Distributed under MIT license.
END

  bundle.description = <<END
${4:Example description}
END

  bundle.repository = 'git@github.com:${5:#{user}}/${6:repo-name}.git'

  bundle.menu '${1:Bundle name}' do |m|
    m.$0
  end
end"
    end
  end

  # Snippet to generate a content assistant
  snippet 'content_assist' do |s|
    s.trigger = 'ca'
    s.expansion = 
"require 'ruble'

content_assist '${1:name}' do |ca|
  ca.scope = '${2:source.ruby}'
  ca.invoke do |context|
    # Write your ruby code here. If there's a non-nil return value for the block that will be used as output/result value.
    # Otherwise we'll take what was piped to STDOUT
    
    # Content Assist is a little odd, it assumes the return value is a string that can be eval'd to an 
    # Array of strings or hashes that are the list of completion proposals.
    [${3:'example', 'values'}].inspect
  end
end"  
  end
  
  # Snippet to generate with_defaults
  snippet 'with_defaults' do |s|
    s.trigger = 'wi'
    s.expansion = 
"with_defaults :${1:scope} => '${2:source.ruby}' do
  $0
end"  
  end
  
  snippet 'env' do |s|
    s.trigger = 'env'
    s.expansion=
"env '${1:source.ruby}' do |e|
  e['${2:TM_COMMENT_START}'] = '${3:# }'
end"
  end

  snippet 'smart_typing_pairs' do |s|
    s.trigger = 'stp'
    s.expansion = "smart_typing_pairs['${1:source.ruby}'] = ['${2:\"}', '$2']"
  end
  
  snippet 'project_template' do |s|
    s.trigger = 'pt'
    s.expansion = "project_template '${1:name}' do |t|
  t.type = :${2:name}
  t.location = '${3:relative_filename.zip}'
  t.description = '${4:description}'
end"
  end
end