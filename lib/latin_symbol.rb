class LatinSymbol
  attr_accessor :name, :value, :repeat_times, :minuend

  def initialize(latin_letter, symbols_attributes)
    symbols_attributes.each do |sym_attrs|
      if sym_attrs.keys[0] == latin_letter
        @value = sym_attrs.values[0][0]['value']
        @repeat_times = sym_attrs.values[0][1]['repeatTimes']
        @minuend = sym_attrs.values[0][2]['minuend']
      end
    end
  end

  def self.symbols_to_value(symbols, symbols_attributes)
    total_value = 0
    (0..symbols.length-1).each do |index|
      index_symbol = self.new(symbols[index], symbols_attributes)
      pre_index_symbol = self.new(symbols[index-1], symbols_attributes)
      next_index_symbol = self.new(symbols[index+1], symbols_attributes)
      repeat_more_than_three = index_symbol.repeat_times == 3 && symbols.match(/\w*#{symbols[index]}{4}\w*/)
      repeat_more_than_one = index_symbol.repeat_times == 0 && symbols.match(/\w*#{symbols[index]}{2}\w*/)
      if (repeat_more_than_one || repeat_more_than_three) || (index < symbols.length-1 && index_symbol.smaller_than?(next_index_symbol) && !index_symbol.minuend.include?(symbols[index+1]))
        total_value = null
      elsif index < symbols.length-1 && next_index_symbol.smaller_than_or_equal?(index_symbol) && index > 0 && pre_index_symbol.smaller_than?(index_symbol)
        next
      elsif index < symbols.length-1 && next_index_symbol.smaller_than_or_equal?(index_symbol)
        total_value += index_symbol.value
      elsif index == symbols.length-1 && index_symbol.smaller_than_or_equal?(pre_index_symbol)
        total_value += index_symbol.value
      elsif index < symbols.length-1 && index_symbol.smaller_than?(next_index_symbol)
        total_value += (next_index_symbol.value - index_symbol.value)
      end
    end
    total_value
  end

  def smaller_than?(latin_symbol)
    self.value < latin_symbol.value ? true :false
  end

  def smaller_than_or_equal?(latin_symbol)
    self.value <= latin_symbol.value ? true :false
  end

end