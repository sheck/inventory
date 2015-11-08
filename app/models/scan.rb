class Scan
  include ActiveModel::Model

  attr_accessor :user, :barcode_image, :list_ids
  attr_reader :item, :query_error, :upc

  validates_presence_of :user
  validates_presence_of :barcode_image
  validates_presence_of :upc, message: "Unable to read barcode"
  validates_absence_of :query_error

  def save
    parse_barcode
    query_amazon
    if valid?
      @item = user.items.new name: title, list_ids: lists
      add_photo_if_available
      @item.save
    end
  end

  private

  def parse_barcode
    if barcode_image
      barcode = ZBar::Image.from_jpeg(barcode_image).process
      @upc = barcode.try(:first).try(:data)
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
      @query = Amazon::Ecs.item_search(@upc, response_group: 'Medium',
                                       search_index: 'All')
      @query_error = @query.try(:error)
    end
  end

  def title
    query_item.get("ItemAttributes/Title")
  end

  def lists
    list_ids.reject(&:empty?)
  end

  def query_item
    @query.items.first
  end

  def add_photo_if_available
    if query_item.get('LargeImage/URL')
      @item.photo = URI.parse(query_item.get('LargeImage/URL'))
    end
  end
end
