require 'ruble'

project_template t(:ruble_template) do |t|
  t.type = :ruby
  t.location = "templates/ruble_template.zip"
  t.description = t(:ruble_template_description)
  t.replace_parameters = true
end