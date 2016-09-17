require 'parser/input_parser'
require 'latin_symbol'

RSpec.describe Symbol do
  let(:input_parser) {InputParser.new}
  let(:symbols_attributes) {input_parser.yaml_parser('resource/latin_symbols_attributes.yml')}
  let(:latin_symbol) {LatinSymbol.new('I', symbols_attributes)}
  describe '#initialize' do
    context 'with attributes of a symbol' do
      it 'should return this symbol instance' do
        value = 1
        repeatTimes = 3
        minuend = ['V', 'X']
        expect(latin_symbol.value).to eq(value)
        expect(latin_symbol.repeat_times).to eq(repeatTimes)
        expect(latin_symbol.minuend).to eq(minuend)
      end
    end
  end

  describe '#smaller_than?' do
    context 'with two symbol' do
      it 'should return whether one symbol value is smaller than another' do
        another_latin_symbol = LatinSymbol.new('V', symbols_attributes)
        expect(latin_symbol.smaller_than?(another_latin_symbol)).to be(true)
      end
    end
  end

  describe '#smaller_than_or_equal?' do
    context 'with two symbol' do
      it 'should return whether one symbol value is smaller than or equal with another' do
        another_latin_symbol = LatinSymbol.new('V', symbols_attributes)
        expect(latin_symbol.smaller_than?(another_latin_symbol)).to be(true)
      end
      it 'should return whether one symbol value is smaller than or equal with another' do
        another_latin_symbol = LatinSymbol.new('I', symbols_attributes)
        expect(latin_symbol.smaller_than_or_equal?(another_latin_symbol)).to be(true)
      end
    end
  end

  describe '#symbols_to_value' do
    context 'when given symbol string' do
      it 'should return the value of the string' do
        symbol_string =  'MCMXLIV'
        expect(LatinSymbol.symbols_to_value(symbol_string, symbols_attributes)).to eq(1944)
      end
      it 'should return the value of the string' do
        symbol_string =  'MMVI'
        expect(LatinSymbol.symbols_to_value(symbol_string, symbols_attributes)).to eq(2006)
      end
    end
  end
end