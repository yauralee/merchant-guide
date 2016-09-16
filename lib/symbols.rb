class Symbols
  attr_accessor :name, :value, :repeat_times, :minuend

  def initialize(name, value, repeat_times, minuend)
    name = name
    value = value
    repeat_times = repeat_times
    minuend = minuend
  end

  def smaller_than?(symbol)
     self.value < symbol.value ? true :false
  end

end