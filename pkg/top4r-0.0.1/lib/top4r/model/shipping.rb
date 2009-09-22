module Top4R
  # Area model
  class Area
    include ModelMixin
    @@ATTRIBUTES = [:id, :area_id, :area_type, :area_name, :parent_id, :zip]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["area_id", "area_type", "area_name", "parent_id", "zip"]
      end
    end
    
    def unmarshal_other_attrs
      @id = @area_id
      self
    end
  end
  
  # LogisticCompany model
  class LogisticCompany
    include ModelMixin
    @@ATTRIBUTES = [:id, :company_id, :company_code, :company_name]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["company_id", "company_code", "company_name"]
      end
    end
    
    def unmarshal_other_attrs
      @id = @company_id
      self
    end
  end
  
  # Delivery model
  class Delivery
    include ModelMixin
    @@ATTRIBUTES = [:tid, :order_type, :company_code, :out_sid, :seller_name, :seller_area_id, 
      :seller_address, :seller_zip, :seller_phone, :seller_mobile, :memo]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
  end # Delivery model
  
  # Shipping model
  class Shipping
    include ModelMixin
    @@ATTRIBUTES = [:id, :tid, :seller_nick, :buyer_nick, :delivery_start, :delivery_end, 
      :out_sid, :item_title, :receiver_name, :receiver_phone, :receiver_mobile, :receiver_location, 
      :status, :type, :freight_payer, :seller_confirm, :company_name]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
    
    def unmarshal_other_attrs
      @id = @out_sid
      if @receiver_location && @receiver_location.size > 0
        @receiver_location = Location.new(@receiver_location)
      else
        @receiver_location = nil
      end
      self
    end
  end
end