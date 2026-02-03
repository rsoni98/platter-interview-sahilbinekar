# Rough Approach
# 1. get the input seperated with commas
# 2. sort the input with item qt e.g {milk: 3, banana:2, bread: 2}
# 3. for calculation get the total with the expected pattern of sale create a method 
# 4. inside the method pass the item list hash and the method should also return hash with total price all item list hash and its respective qualtity and price as per the sale and also the total saving on alover item list.
# 5. to implement the method:
#   a. group the product with the sale qualtity standard.
#   b. add the condition for on sale product.
#   c. then add the price for the respective product.
#   d. for calculating how much we saved on the list we get all the total of each item according to the unit price and then we substract the sale total price for it.

require "active_support/core_ext/hash/indifferent_access"
require "pry"
class PriceCalculator

  def initialize
    get_input
    sale_product_group
  end

    STORE_ITEMS = {
      "milk" =>{
        "unit_price" => 3.97,
        "sale" => true,
        "qt" => 2,
        "sale_price" => 5.00
      },
      "bread" => {
        "unit_price" => 2.17,
        "sale" => true,
        "qt" => 3,
        "sale_price" => 6.00
      },
      "banana" => {
        "unit_price" => 0.99,
        "sale" => false,
        "qt" => 0,
        "sale_price" => 0
      },
      "apple" => {
        "unit_price" => 0.89,
        "sale" => false,
        "qt" => 0,
        "sale_price" => 0
      }
    }

  def get_input
    @input_list = gets.chomp
  end

  def calculate_sale_total

  end

  def product_group
    sorted_list = Hash.new(0)

    @input_list.split(',').each do |i|
      sorted_list[i.strip] += 1
    end
    sorted_list
  end

  def sale_product_group
    sale_sorted_list = []

    product_group.each do |item, count|
      if STORE_ITEMS[item]["sale"]
        while count > 0
          grounp_by_qt = [STORE_ITEMS[item]["qt"], count].min
          sale_sorted_list << {item => grounp_by_qt}
          count -= grounp_by_qt
        end
      else
        sale_sorted_list << {item => count}
      end
    end

    sale_sorted_list
  end
end

PriceCalculator.new()