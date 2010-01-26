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

snippet 'command' do |s|
  s.trigger = 'co'
  s.scope = 'source.ruby'
  s.expansion = 
"require 'radrails'

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
