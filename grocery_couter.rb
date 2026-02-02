require "active_support/hash_with_indifferent_access"
class PriceCalculator
  def initialize
    get_input
  end
    STORE_ITEMS = {
      milk:{
        unit_price: 3.97,
        sale: true,
        qt: 2,
        sale_price: 5.00
      },
      bread: {
        unit_price: 2.17,
        sale: true,
        qt: 3,
        sale_price: 6.00
      },
      banana: {
        unit_price: 0.99,
        sale: false,
        qt: 0,
        sale_price: 0
      },
      apple: {
        unit_price: 0.89,
        sale: false,
        qt: 0,
        sale_price: 0
      }
    }

  def get_input
    @input_list = gets.chomp
  end
  
end

PriceCalculator.new()