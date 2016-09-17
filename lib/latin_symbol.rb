class LatinSymbol
  attr_accessor :value, :repeat_times, :minuend

  def initialize(latin_letter, symbols_attributes)
    symbols_attributes.each do |sym_attrs|
      if sym_attrs.keys[0] == latin_letter
        @value = sym_attrs.values[0][0]['value']
        @repeat_times = sym_attrs.values[0][1]['repeatTimes']
        @minuend = sym_attrs.values[0][2]['minuend']
      end
    end
  end

  def smaller_than?(latin_symbol)
    self.value < latin_symbol.value ? true :false
  end

  def smaller_than_or_equal?(latin_symbol)
    self.value <= latin_symbol.value ? true :false
  end

end