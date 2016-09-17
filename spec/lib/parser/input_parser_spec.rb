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
    context 'with known conditions' do
      it 'should return equivalent and transactions' do
        file_name = 'resource/known_conditions.yml'
        conditions = {"equivalents" => [{"glob"=>"I"}, {"prok"=>"V"}, {"pish"=>"X"}, {"tegj"=>"L"}],
                      "transaction1" => ["glob glob", "Silver", "34 Credits"],
                      "transaction2" => ["glob prok", "Gold", "57800 Credits"],
                      "transaction3" => ["pish pish", "Iron", "3910 Credits"]}
        expect(input_parser.yaml_parser(file_name)).to eq(conditions)
      end
    end
  end

  describe '#questions' do
    context 'with questions' do
      it 'should return details of questions' do
        file_name = 'resource/questions.yml'
        questions = {"how many Credits" => [{"glob prok"=>"Silver"}, {"glob prok"=>"Gold"}, {"glob prok"=>"Iron"}],
                     "how much is" => ["pish tegj glob glob"],
                     "how much wood" => ["could a woodchuck chuck if a woodchuck could chuck wood"]}
        expect(input_parser.yaml_parser(file_name)).to eq(questions)
      end
    end
  end
end