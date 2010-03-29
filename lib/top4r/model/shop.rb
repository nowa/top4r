module Top4R
  # SellerCat Model
  class SellerCat
    include ModelMixin
    @@ATTRIBUTES = [:id, :cid, :parent_cid, :name, :pict_url, :sort_order]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
    
    def unmarshal_other_attrs
      @id = @cid
      self
    end
  end
  
  # Shop Model
  class Shop
    include ModelMixin
    @@ATTRIBUTES = [:id, :sid, :cid, :nick, :title, :desc, :bulletin, :pic_path, :created, :modified]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["sid", "cid", "title", "nick", "desc", "bulletin", "pic_path", "created", "modified"]
      end
    end
    
    def unmarshal_other_attrs
      @id = @sid
      self
    end
  end
end