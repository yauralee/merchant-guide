require 'latin_symbol'

class Calculator

  attr_accessor :metals_prices

  def initialize(known_transactions, symbols_attributes)
    metals_prices = []
    known_transactions.each do |transaction|
      amount_value = LatinSymbol.symbols_to_value(transaction.values[0][0]['amountSymbols'], symbols_attributes)
      credits = transaction.values[0][1]['credits']
      metal_price = credits.to_f / amount_value
      each_metal_price = {}
      each_metal_price[transaction.keys[0]] = metal_price
      metals_prices << each_metal_price
    end
    @metals_prices = metals_prices
  end

  # def



end
