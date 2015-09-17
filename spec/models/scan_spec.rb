require 'rails_helper'

describe Scan do
  describe "#save" do
    it 'creates an item from a barcode image' do
      barcode = File.open("spec/support/barcode.jpg", mode: "rb")
      scan = Scan.new(barcode_image: barcode, list_ids: [], user: create(:user))

      scan.save

      expect(scan.errors).to be_blank
      expect(Item.count).to eq(1)
      item = Item.first
      expect(item.name).to eq("Seven Men: And the Secret of Their Greatness")
      expect(item.photo).to_not be_blank
    end
  end

  describe "#parse_barcode" do
    it 'accepts an image and returns a barcode' do
      barcode = File.open("spec/support/barcode.jpg", mode: "rb")
      scan = Scan.new(barcode_image: barcode, list_ids: [], user: create(:user))

      result = scan.parse_barcode

      expect(result).to eq("9781595554697")
    end
  end
end
