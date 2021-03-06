require '../lib/latin_symbol'

class Calculator

  attr_accessor :metals_prices, :symbols_attributes

  def initialize(known_transactions, symbols_attributes)
    metals_prices = {}
    known_transactions.each do |transaction|
      amount_value = Calculator.symbols_to_value(transaction.values[0][0]['amountSymbols'], symbols_attributes)
      credits = transaction.values[0][1]['credits']
      metal_price = credits.to_f / amount_value
      metals_prices[transaction.keys[0]] = metal_price
    end
    @metals_prices = metals_prices
  end

  def self.calculate_results(questions, symbols_attributes, known_transactions)
    result_array = []
    questions.values.each do |each_kind_question|
      each_kind_question.each do |each_question|
        params_for_send  = [each_question, symbols_attributes]
        if questions.key(each_kind_question) == 'how much is'
          result = Calculator.send(:symbols_to_value, *params_for_send)
        elsif questions.key(each_kind_question) == 'how many Credits'
          result = Calculator.new(known_transactions, symbols_attributes).send(:metal_total_price, *params_for_send)
        else
          result =  Calculator.send(:have_no_idea, each_question)
        end
        result_array << result
      end
    end
    result_array
  end

  def self.symbols_to_value(symbols, symbols_attributes)
    amount_value = 0
    (0..symbols.length-1).each do |index|
      index_symbol = LatinSymbol.new(symbols[index], symbols_attributes)
      pre_index_symbol = LatinSymbol.new(symbols[index-1], symbols_attributes)
      next_index_symbol = LatinSymbol.new(symbols[index+1], symbols_attributes)
      repeat_more_than_three = index_symbol.repeat_times == 3 && symbols.match(/\w*#{symbols[index]}{4}\w*/)
      repeat_more_than_one = index_symbol.repeat_times == 0 && symbols.match(/\w*#{symbols[index]}{2}\w*/)
      if (repeat_more_than_one || repeat_more_than_three) || (index < symbols.length-1 && index_symbol.smaller_than?(next_index_symbol) && !index_symbol.minuend.include?(symbols[index+1]))
        amount_value = null
      elsif index < symbols.length-1 && next_index_symbol.smaller_than_or_equal?(index_symbol) && index > 0 && pre_index_symbol.smaller_than?(index_symbol)
        next
      elsif index < symbols.length-1 && next_index_symbol.smaller_than_or_equal?(index_symbol)
        amount_value += index_symbol.value
      elsif index == symbols.length-1 && index_symbol.smaller_than_or_equal?(pre_index_symbol)
        amount_value += index_symbol.value
      elsif index < symbols.length-1 && index_symbol.smaller_than?(next_index_symbol)
        amount_value += (next_index_symbol.value - index_symbol.value)
      end
    end
    amount_value
  end

  def metal_total_price(amountSymbols_and_metal, symbols_attributes)
    amount_value = Calculator.symbols_to_value(amountSymbols_and_metal.keys[0], symbols_attributes)
    @metals_prices[amountSymbols_and_metal.values[0]] * amount_value
  end

  def self.have_no_idea(product_and_condition)
    'I have no idea what you are talking about' unless['Silver', 'Gold', 'Iron'].include?(product_and_condition.keys[0])
  end
end
