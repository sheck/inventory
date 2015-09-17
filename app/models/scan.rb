class Scan
  include ActiveModel::Model

  attr_accessor :user, :barcode_image, :list_ids, :upc
  attr_reader :item, :query_error

  validates_presence_of :user
  validates_presence_of :barcode_image
  validates_presence_of :upc, message: "Unable to read barcode"
  validates_absence_of :query_error

  def save
    @upc = parse_barcode
    @query = query_amazon
    @query_error = @query.try(:error)
    if valid?
      az_item = @query.items.first
      @item = user.items.new name: az_item.get("ItemAttributes/Title"), list_ids: list_ids.reject(&:empty?)
      if az_item.get('LargeImage/URL')
        @item.photo = URI.parse(az_item.get('LargeImage/URL'))
      end
      @item.save
    end
  end

  def parse_barcode
    if barcode_image
      barcode = ZBar::Image.from_jpeg(barcode_image).process
      barcode.try(:first).try(:data)
    end
  end

  def query_amazon
    if @upc
      Amazon::Ecs.options = {
        :version => "2013-08-01",
        :service => "AWSECommerceService",
        :associate_tag => ENV["AMAZON_ASSOCIATE_TAG"],
        :AWS_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
        :AWS_secret_key => ENV["AWS_SECRET_ACCESS_KEY"]
      }
      Amazon::Ecs.item_search(@upc, response_group: 'Medium', search_index: 'All')
    end
  end
end
