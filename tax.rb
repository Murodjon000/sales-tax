require 'csv'
INPUT =  CSV.read("./inputs/input.csv")


class SalesTaxes
    TAX_EXEMPT_ITEM = ["chocolates","book","pills","chocolate"]
    IMPORT_TAX = 0.05
    SALES_TAX = 0.10
    BOTH_TAX = 0.15
   
    def get_input(input_array)
      total_tax = 0
      total_price = 0
      output = []
      input_array.each do |each_item|
         s_item = each_item.split
         quantity = s_item[0].to_i
         price = s_item[-1].to_f
         p = each_item.split("  ")
         product = p[0].delete("/0-9-./").strip
         tax = tax_cal(price,product)
         total_tax += tax
         tax_price = (price.to_f + tax)
         total_price += tax_price
         output << "#{quantity} #{product}: #{tax_price.round(2)}"
      end
      output << "Sales Tax: #{total_tax.round(2) }" 
      output  << "Total: #{total_price.round(2)}"
      return output
    end
   
    def tax_cal(price,product)
      tax_exclude = []
      a_product = product.split(" ")
      tax_exclude = a_product & TAX_EXEMPT_ITEM
      if product.include?("imported") and tax_exclude.length == 0
        tax = ((price * BOTH_TAX)*20).round/20.0
      elsif product.include?("imported") and tax_exclude.length != 0
        tax = ((price * IMPORT_TAX)*20).round/20.0
      elsif tax_exclude.length == 0 
        tax = ((price * SALES_TAX)*20).round/20.0
      else
        tax = 0
      end
      return tax
    end
   
end

inputs_1 = INPUT[1..-1]

RECIPT = [] 

inputs_1.each do |el|
  RECIPT << el.join(" ")
end

data = SalesTaxes.new

CSV.open('./outputs/output.csv', 'a+') do |row|
 row << data.get_input(RECIPT)
end