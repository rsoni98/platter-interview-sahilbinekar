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
    @input_list = get_input
    @quantity_grouped_product_list = product_group
    @total_product_unit_cost = calculate_product_total
    @total_product_sales_cost, @final_table_data = calculate_sale_product_total
    output_table
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
    puts "Please enter all the items purchased separated by a comma"
    gets.chomp
  end

  def output_table
    puts format("\n%-10s %-10s %s", "Item", "Quantity", "Price")
    puts "-" * 35

    @final_table_data.each do |item|
      puts format("%-10s %-10s $%s",item[0].capitalize, item[1]["qt"], item[1]["price"])
    end
    puts "\nTotal Price $#{@total_product_sales_cost} \nYou Saved $#{sprintf('%.2f', (@total_product_unit_cost - @total_product_sales_cost))} today"
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

    @quantity_grouped_product_list.each do |item, count|
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

  def calculate_sale_product_total
    sale_product_list = sale_product_group
    sale_total_cost = 0
    final_table_hash = {}

    sale_product_list.flat_map(&:to_a).each do |item|
      if STORE_ITEMS[item[0]]["sale"] && (STORE_ITEMS[item[0]]["qt"] == item[1])
        final_table_hash[item[0]] ||= {"qt" => 0, "price" => 0 }
        sale_total_cost = sale_total_cost + STORE_ITEMS[item[0]]["sale_price"]
        final_table_hash[item[0]]["qt"] += item[1]
        final_table_hash[item[0]]["price"]+= STORE_ITEMS[item[0]]["sale_price"]
      else
        final_table_hash[item[0]] ||= {"qt" => 0, "price" => 0 }
        sale_total_cost = sale_total_cost + (STORE_ITEMS[item[0]]["unit_price"] * item[1])
        final_table_hash[item[0]]["qt"] += item[1]
        final_table_hash[item[0]]["price"]+= (STORE_ITEMS[item[0]]["unit_price"] * item[1])
      end
    end

    return sale_total_cost, final_table_hash
  end

  def calculate_product_total
    product_list = @quantity_grouped_product_list
    product_list.inject(0) {|res, item| res + (STORE_ITEMS[item[0]]["unit_price"] * item[1])}
  end

end

PriceCalculator.new()