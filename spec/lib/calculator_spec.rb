require 'parser/input_parser'
require 'Calculator'

RSpec.describe Calculator do
  let(:input_parser) {InputParser.new}
  let(:known_transactions) {input_parser.yaml_parser('resource/known_transactions.yml')}
  let(:symbols_attributes) {input_parser.yaml_parser('resource/latin_symbols_attributes.yml')}
  describe '#initialize' do
    context 'with known transactions and symbols attributes' do
      it 'should return calculator instance with metal price as attribute' do
        metals_prices = [{"Silver"=>17.0}, {"Gold"=>14450.0}, {"Iron"=>195.5}]
        expect(Calculator.new(known_transactions, symbols_attributes).metals_prices).to eq(metals_prices)
      end
    end
  end
end
