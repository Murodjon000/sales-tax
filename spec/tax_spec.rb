require 'rspec'
require_relative "../tax.rb"

RSpec.describe SalesTaxes do
    let(:tax) {SalesTaxes.new}
    let(:input_1) {["1 book 12.49", "1 music cd 14.99", "1 chocolate bar 0.85"]}
    let(:input_2) {["1 imported box of chocolates 10.00", "1 imported bottle of perfume 47.50"]}
    let(:input_3) {["1 imported bottle of perfume 27.99", "1 bottle of perfume 18.99", "1 packet of headache pills 9.75", "1 box of imported chocolates 11.25"]}
    let(:output_1) {["1 book: 12.49", "1 music cd: 16.49", "1 chocolate bar: 0.85", "Sales Tax: 1.5", "Total: 29.83"]}
    let(:output_2) {["1 imported box of chocolates: 10.5", "1 imported bottle of perfume: 54.65", "Sales Tax: 7.65", "Total: 65.15"]}
    let(:output_3) {["1 imported bottle of perfume: 32.19", "1 bottle of perfume: 20.89", "1 packet of headache pills: 9.75", "1 box of imported chocolates: 11.8", "Sales Tax: 6.65", "Total: 74.63"]}
    describe "#SalesTaxes get_input method" do
        it "check is first output correct" do
         expect(tax.get_input(input_1)).to eq(output_1)
        end
        it "check is second output correct" do
            expect(tax.get_input(input_2)).to eq(output_2)
        end
        it "check is third output correct" do
         expect(tax.get_input(input_3)).to eq(output_3)
        end
    end
    describe "#SalesTaxes tax_calc method" do
        it "check is book not taxed" do
         expect(tax.tax_cal(12.49,"book")).to eq(0)
        end
        it "check is chocolate not taxed" do
            expect(tax.tax_cal(0.85,"chocolate bar")).to eq(0)
        end
        it "check is music taxed to  1.5" do
         expect(tax.tax_cal(14.99,"music cd")).to eq(1.5)
        end

        it "check is imported box of chocolates taxed" do
            expect(tax.tax_cal(10.00,"imported box of chocolates")).to eq(0.5)
        end
        it "check is imported bottle of perfume taxed" do
            expect(tax.tax_cal(47.50,"imported bottle of perfume")).to eq(7.15)
        end
        it "check is packet of headache pills not taxed" do
         expect(tax.tax_cal(9.75,"packet of headache pills")).to eq(0)
        end

        it "check is imported bottle of perfume taxed" do
            expect(tax.tax_cal(18.99,"bottle of perfume")).to eq(1.9)
        end
 
    end
end