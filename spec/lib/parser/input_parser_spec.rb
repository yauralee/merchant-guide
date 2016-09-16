require 'parser/input_parser'

RSpec.describe InputParser, type: :parser do
  let(:input_parser) {InputParser.new}
  describe '#corresponding_symbol_and_value' do
    context 'with symbols and values' do
      it 'should return the value of symbols' do
        file_name = 'resource/corresponding_symbol_and_value.yml'
        symbols_and_values = {'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000}
        expect(input_parser.yaml_parser(file_name)).to eq(symbols_and_values)
      end
    end
  end

  describe '#known_conditions' do
    context 'with known conditions' do
      it 'should return equivalent and transactions' do
        file_name = 'resource/known_conditions.yml'
        conditions = {"equivalent" => [{"glob"=>"I"}, {"prok"=>"V"}, {"pish"=>"X"}, {"tegj"=>"L"}],
                      "transaction1" => ["glob glob", "Silver", "34 Credits"],
                      "transaction2" => ["glob prok", "Gold", "57800 Credits"],
                      "transaction3" => ["pish pish", "Iron", "3910 Credits"]}
        expect(input_parser.yaml_parser(file_name)).to eq(conditions)
      end
    end
  end

  describe '#symbol_features' do
    context 'with features of symbols' do
      it 'should return repeate times and minuend of symbols' do
        file_name = 'resource/symbol_features.yml'
        features = {"CanBeSubtractedFrom" => [{"I"=>["V", "X"]}, {"X"=>["L", "C"]}, {"C"=>["D", "M"]}, {"V"=>nil}, {"D"=>nil}, {"L"=>nil}],
                    "canNeverBeRepeated" => ["D", "L", "V"],
                    "canRepeateThreeTimes" => ["I", "X", "C", "M"]}
        expect(input_parser.yaml_parser(file_name)).to eq(features)
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