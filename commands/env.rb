require 'radrails'

command 'Show ENV' do |cmd|
  cmd.input = :none
  cmd.output = :show_as_tooltip
  cmd.key_binding = "CONTROL+SHIFT+E"
  cmd.invoke do |context|
    str = ""
    ENV.each {|key, value| str << "#{key}: #{value}\n" }
    str
  end
end