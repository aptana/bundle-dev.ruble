require 'ruble'

# Snippet to generate a snippet
snippet 'snippet' do |s|
  s.trigger = 'sn'
  s.scope = 'source.ruby'
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
  s.scope = 'source.ruby'
  s.expansion = "m.command '${1:command_or_snippet_name}'
m.$0"
end

# Insert a menu separator
snippet 'm.separator' do |s|
  s.trigger = 'm.'
  s.scope = 'source.ruby'
  s.expansion = "m.separator
m.$0"
end

# Generate a sub-menu
snippet 'm.menu' do |s|
  s.trigger = 'm.'
  s.scope = 'source.ruby'
  s.expansion = "m.menu '${1:submenu}' do |m|
  m.$0
end"
end

# Snippet to generate a command
snippet 'command' do |s|
  s.trigger = 'co'
  s.scope = 'source.ruby'
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
  s.scope = 'source.ruby'
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
(c) Copyright #{Time.now.year} ${3:#{org}}. Distributed under GPLv3 license.
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
  s.scope = 'source.ruby'
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