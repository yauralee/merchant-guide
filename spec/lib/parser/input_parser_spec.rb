require 'parser/input_parser'

RSpec.describe InputParser, type: :parser do
  let(:input_parser) {InputParser.new}
  describe '#latin_symbols_attributes' do
    context 'with symbols attributes' do
      it 'should return symbols as hash' do
        file_name = 'resource/latin_symbols_attributes.yml'
        symbols = [{"I"=>[{"value"=>1}, {"repeatTimes"=>3}, {"minuend"=>["V", "X"]}]},
                   {"V"=>[{"value"=>5}, {"repeatTimes"=>0}, {"minuend"=>nil}]},
                   {"X"=>[{"value"=>10}, {"repeatTimes"=>3}, {"minuend"=>["L", "C"]}]},
                   {"L"=>[{"value"=>50}, {"repeatTimes"=>0}, {"minuend"=>nil}]},
                   {"C"=>[{"value"=>100}, {"repeatTimes"=>3}, {"minuend"=>["D", "M"]}]},
                   {"D"=>[{"value"=>500}, {"repeatTimes"=>0}, {"minuend"=>nil}]},
                   {"M"=>[{"value"=>1000}, {"repeatTimes"=>3}, {"minuend"=>nil}]}]
        expect(input_parser.yaml_parser(file_name)).to eq(symbols)
      end
    end
  end

  describe '#known_conditions' do
    context 'with known transactions' do
      it 'should return transactions details as hash' do
        file_name = 'resource/known_transactions.yml'
        conditions = [{"Silver"=>[{"amountSymbols"=>"II"}, {"credits"=>34}]},
                      {"Gold"=>[{"amountSymbols"=>"IV"}, {"credits"=>57800}]},
                      {"Iron"=>[{"amountSymbols"=>"XX"}, {"credits"=>3910}]}]
        expect(input_parser.yaml_parser(file_name)).to eq(conditions)
      end
    end
  end

  describe '#questions' do
    context 'with questions' do
      it 'should return details of questions' do
        file_name = 'resource/questions.yml'
        questions = {"how much is"=>["XLII"],
                     "how many Credits"=>[{"IV"=>"Silver"}, {"IV"=>"Gold"}, {"IV"=>"Iron"}],
                     "how much" => [{"wood"=>"could a woodchuck chuck if a woodchuck could chuck wood"}]}
        expect(input_parser.yaml_parser(file_name)).to eq(questions)
      end
    end
  end
end