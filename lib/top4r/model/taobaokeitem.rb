module Top4R
  
  # TaobaokeItem Model
  class TaobaokeItem
    include ModelMixin
    @@ATTRIBUTES = [:id, :iid, :num_iid, :title, :nick, :pic_url, :price, :click_url, :commission, :commission_rate, 
      :commission_num, :commission_volume, :shop_click_url, :seller_credit_score, :item_location, :volume]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["iid", "num_iid", "title", "pic_url", "price", "nick", "click_url"]
      end
    end
    
    def unmarshal_other_attrs
      @id = @iid
      
      self
    end
  end
  
end