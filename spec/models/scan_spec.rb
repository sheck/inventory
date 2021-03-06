require "rails_helper"

describe Scan do
  describe "#save" do
    it "creates an item from a barcode image" do
      VCR.use_cassette("barcode") do |cassette|
        Timecop.freeze(cassette.originally_recorded_at || Time.now) do
          barcode = File.open("spec/support/barcode.jpg", mode: "rb")
          scan = Scan.new(barcode_image: barcode, user: create(:user))

          scan.save

          expect(scan.errors).to be_blank
          expect(Item.count).to eq(1)
          item = Item.first
          expect(item.name).to eq("Seven Men: And the Secret of Their Greatness")
          expect(item.photo).to_not be_blank
        end
      end
    end
  end
end
