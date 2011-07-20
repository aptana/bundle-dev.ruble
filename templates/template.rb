require 'ruble'

project_template "Ruble Template" do |t|
  t.type = :ruby
  t.location = "templates/ruble_template.zip"
  t.description = "A simple Ruble sample"
  t.replace_parameters = true
end