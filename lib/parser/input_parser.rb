require 'yaml'

class InputParser
  def yaml_parser(file_name)
    YAML.load_file(file_name)
  end
end