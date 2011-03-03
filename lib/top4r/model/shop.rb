module Top4R
  # SellerCat Model
  class SellerCat
    include ModelMixin
    @@ATTRIBUTES = [:id, :type, :cid, :parent_cid, :name, :pict_url, :sort_order, :created, :modified]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
    
    def unmarshal_other_attrs
      @id = @cid
      self
    end
  end
  
  # ShopScore Model
  class ShopScore
    include ModelMixin
    @@ATTRIBUTES = [:item_score, :service_score, :delivery_score]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
    
    def unmarshal_other_attrs
      @id = 0
      self
    end
  end
  
  # Shop Model
  class Shop
    include ModelMixin
    @@ATTRIBUTES = [:id, :sid, :cid, :nick, :title, :desc, :bulletin, :pic_path, :created, :modified, :shop_score, :remain_count]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["sid", "cid", "title", "nick", "desc", "bulletin", "pic_path", "created", "modified"]
      end
    end
    
    def unmarshal_other_attrs
      @id = @sid
      
      if @shop_score && @shop_score.size > 0
        @shop_score = ShopScore.new(@shop_score)
      else
        @shop_score = nil
      end
      
      self
    end
  end
end
