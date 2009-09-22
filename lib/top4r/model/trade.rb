module Top4R
  # Order model
  class Order
    include ModelMixin
    @@ATTRIBUTES = [:id, :iid, :sku_id, :sku_properties_name, :item_meal_name, :num, :title, 
      :price, :pic_path, :seller_nick, :buyer_nick, :type, :created, :refund_status, :tid, 
      :outer_iid, :outer_sku_id, :total_fee, :payment, :discount_fee, :adjust_fee, :status, 
      :snapshot_url, :timeout_action_time]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["orders.title", "orders.price", "orders.num", "orders.iid", "orders.status", "orders.tid", 
          "orders.total_fee", "orders.payment", "orders.pic_path"]
      end
    end
    
    def confirm_fees
      @client.trade(@tid, :confirmfee, {:is_detail => "IS_CHILD"})
    end
    
    def unmarshal_other_attrs
      @id = 0
      self
    end
  end
  
  # TradeConfirmFee model
  class TradeConfirmFee
    include ModelMixin
    @@ATTRIBUTES = [:id, :confirm_fee, :confirm_post_fee, :is_last_detail_order]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
    
    def unmarshal_other_attrs
      @id = 0
      self
    end
  end
  
  # Trade model
  class Trade
    include ModelMixin
    @@ATTRIBUTES = [:id, :seller_nick, :buyer_nick, :title, :type, :created, :iid, :price, 
      :pic_path, :num, :tid, :buyer_message, :sid, :shipping_type, :alipay_no, :payment, 
      :discount_fee, :adjust_fee, :snapshot_url, :status, :seller_rate, :buyer_rate, 
      :buyer_memo, :seller_memo, :pay_time, :end_time, :modified, :buyer_obtain_point_fee, 
      :point_fee, :real_point_fee, :total_fee, :post_fee, :buyer_alipay_no, :receiver_name,
      :receiver_state, :receiver_city, :receiver_district, :receiver_address, :receiver_zip, 
      :receiver_mobile, :receiver_phone, :consign_time, :buyer_email, :commission_fee, 
      :seller_alipay_no, :seller_mobile, :seller_phone, :seller_name, :seller_email, 
      :available_confirm_fee, :has_postFee, :received_payment, :cod_fee, :timeout_action_time, :orders]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
      
      def default_public_fields
        ["buyer_nick", "seller_nick", "tid", "modified", "title", "type", "status", "created", "price", 
          "sid", "pic_path", "iid", "payment", "alipay_no", "shipping_type", "pay_time", "end_time", 
          "orders"] + Top4R::Order.default_public_fields
      end
    end
    
    def close(reason = "现关闭本交易！")
      @client.trade(@tid, :close, {:close_reason => reason})
    end
    
    def add_memo(memo)
      valid_memo(memo)
      @client.trade(@tid, :add_memo, {:memo => memo})
    end
    
    def update_memo(memo)
      valid_memo(memo)
      @client.trade(@tid, :update_memo, {:memo => memo})
    end
    
    def confirm_fees
      @client.trade(@tid, :confirmfee, {:is_detail => "IS_FATHER"})
    end
    
    def deliver(options = {}, &block)
      delivery = Delivery.new(options)
      yield delivery if block_given?
      delivery.tid = @tid
      @client.deliver_trade(delivery)
    end
    
    def unmarshal_other_attrs
      @id = @tid
      if @orders.is_a?(Array)
        @orders = @orders.map{|order| Order.new(order)}
      end
      self
    end
    
    private
      def valid_memo(memo)
        raise ArgumentError, "Invalid param: memo" if memo
        raise ArgumentError, "Invalid param length: Memo must be less than 1000 characters" if memo.size > 1000
      end
  end
end