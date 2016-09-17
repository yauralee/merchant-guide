require 'parser/input_parser'
require 'Calculator'

RSpec.describe Calculator do
  let(:input_parser) {InputParser.new}
  let(:known_transactions) {input_parser.yaml_parser('resource/known_transactions.yml')}
  let(:symbols_attributes) {input_parser.yaml_parser('resource/latin_symbols_attributes.yml')}
  let(:calculator) {Calculator.new(known_transactions, symbols_attributes)}
  let(:questions) {input_parser.yaml_parser('resource/questions.yml')}
  describe '#initialize' do
    context 'with known transactions and symbols attributes' do
      it 'should return calculator instance with metal price as attribute' do
        metals_prices = {"Silver"=>17.0, "Gold"=>14450.0, "Iron"=>195.5}
        expect(Calculator.new(known_transactions, symbols_attributes).metals_prices).to eq(metals_prices)
      end
    end
  end

  describe '#calculate_results' do
    context 'with questions' do
      it 'should return result array' do
        result_array = [42, 68.0, 57800.0, 782.0, "I have no idea what you are talking about"]
        expect(Calculator.calculate_results(questions, symbols_attributes, known_transactions)).to eq(result_array)
      end
    end
  end

  describe '#symbols_to_value' do
    context 'when given symbol string' do
      it 'should return the value of the string' do
        symbol_string =  'MCMXLIV'
        expect(Calculator.symbols_to_value(symbol_string, symbols_attributes)).to eq(1944)
      end
      it 'should return the value of the string' do
        symbol_string =  'MMVI'
        expect(Calculator.symbols_to_value(symbol_string, symbols_attributes)).to eq(2006)
      end
      it 'should return the value of the string' do
        symbol_string =  'XLII'
        expect(Calculator.symbols_to_value(symbol_string, symbols_attributes)).to eq(42)
      end
    end
  end

  describe '#metal_total_price' do
    context 'when given metal and amount symbols' do
      it 'should return total price of this metal' do
        amountSymbols_and_metal = {'IV' => 'Silver'}
        expect(calculator.metal_total_price(amountSymbols_and_metal, symbols_attributes)).to eq(68)
      end
    end
  end

  describe '#have_no_idea' do
    context 'when product is not metal' do
      it 'should return have no idea' do
        product_and_condition = {'wood' => 'could a woodchuck chuck if a woodchuck could chuck wood'}
        expect(calculator.have_no_idea(product_and_condition)).to eq('I have no idea what you are talking about')
      end

    end

  end
end
