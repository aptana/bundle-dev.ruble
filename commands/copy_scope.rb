require 'radrails'

command "Copy Scope" do |cmd|
  cmd.key_binding = "CONTROL+SHIFT+COMMAND+C"
  cmd.input = :none
  cmd.output = :copy_to_clipboard
  cmd.invoke { ENV['TM_SCOPE'] }
end

