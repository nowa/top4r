# -*- encoding : utf-8 -*-
module Top4R
  
  # TaobaokeShop Model
  class TaobaokeShop
    include ModelMixin
    @@ATTRIBUTES = [:user_id, :shop_title, :click_url, :commission_rate, :seller_credit, :shop_type, :total_auction, :auction_count]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["user_id", "shop_title", "click_url", "commission_rate"]
      end
    end
    
    def unmarshal_other_attrs
      @id = @user_id
      
      self
    end
  end
  
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
