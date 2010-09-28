module Top4R
  # ItemImg Model
  class ItemImg
    include ModelMixin
    @@ATTRIBUTES = [:id, :url, :position, :created]
    attr_accessor *@@ATTRIBUTES

    class << self
      def attributes; @@ATTRIBUTES; end
    end
  end
  
  # PropImg Model
  class PropImg
    include ModelMixin
    @@ATTRIBUTES = [:id, :url, :properties, :position, :created]
    attr_accessor *@@ATTRIBUTES

    class << self
      def attributes; @@ATTRIBUTES; end
    end
  end
  
  # Sku Model
  class Sku
    include ModelMixin
    @@ATTRIBUTES = [:id, :sku_id, :iid, :properties, :quantity, :price, :outer_id, :created, :modified, :status]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
    
    def unmarshal_other_attrs
      @id = @sku_id
    end
  end
  
  # Video Model
  class Video
    include ModelMixin
    @@ATTRIBUTES = [:id, :video_id, :url, :created, :modified, :iid, :num_iid]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
  end
  
  # Item Model
  class Item
    include ModelMixin
    @@ATTRIBUTES = [:id, :iid, :detail_url, :num_iid, :title, :nick, :type, :cid, 
      :seller_cids, :props, :input_pids, :input_str, :desc, :pic_url, :num, :valid_thru, 
      :list_time, :delist_time, :stuff_status, :location, :price, :post_fee, :express_fee, 
      :ems_fee, :has_discount, :freight_payer, :has_invoice, :has_warranty, :has_showcase, 
      :modified, :increment, :approve_status, :postage_id, :product_id, :auction_point, 
      :property_alias, :item_imgs, :prop_imgs, :skus, :outer_id, :is_virtual, :is_taobao, 
      :is_ex, :is_timing, :videos, :is_3D, :score, :volume, :one_station, :second_kill, 
      :auto_fill, :props_name, :violation, :created, :is_prepay, :ww_status, :promoted_service]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["approve_status", "iid", "num_iid", "title", "nick", "type", "cid", "pic_url", "num", "props", 
          "valid_thru", "list_time", "price", "has_discount", "has_invoice", "has_warranty", 
          "has_showcase", "modified", "delist_time", "postage_id", "seller_cids", "outer_id", "detail_url"]
      end
    end
    
    def search(q)
      @client.items_onsale(q)
    end
    
    def unmarshal_other_attrs
      @id = @iid
      if @location && @location.size > 0
        @location = Location.new(@location)
      else
        @location = nil
      end
      # if @item_imgs.is_a?(Array) && @item_imgs.size > 0
      #         @item_imgs.map {|img| ItemImg.new(img)}
      #       else
      #         @item_imgs = []
      #       end
      #       if @prop_imgs.is_a?(Array) && @prop_imgs.size > 0
      #         @prop_imgs.map {|img| PropImg.new(img)}
      #       else
      #         @prop_imgs = []
      #       end
      
      self
    end
  end
end