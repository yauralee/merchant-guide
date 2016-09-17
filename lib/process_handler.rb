# require 'require_all'
# require_all 'lib'
require '../lib/parser/input_parser'
require '../lib/calculator'
require '../lib/result_printer'

class ProcessHandler
  def self.process(latin_symbols_attrs, known_transactions, questions)
    symbols_attrs = InputParser.new.yaml_parser(latin_symbols_attrs)
    known_transactions = InputParser.new.yaml_parser(known_transactions)
    questions = InputParser.new.yaml_parser(questions)
    result_array = Calculator.calculate_results(questions, symbols_attrs, known_transactions)
    ResultPrinter.new.print_result(result_array)
  end
end

ProcessHandler.process('../resource/latin_symbols_attributes.yml', '../resource/known_transactions.yml', '../resource/questions.yml')