require 'ruble'

command t(:show_scope) do |cmd|
  cmd.key_binding = "CONTROL+SHIFT+P"
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.invoke { ENV['TM_SCOPE'] }
end

