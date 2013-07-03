# -*- encoding : utf-8 -*-
module Top4R
  module LoggedInUserMixin
    module InstanceMethods
      def trades(method = :bought_list, options = {})
        @client.trades_for(method, options)
      end
      
      def suites(service_code, options = {})
        @client.suites(self.nick, service_code, :list, options)
      end
      
      def search_items(q = nil, options = {})
        @client.items_onsale(q, :onsale_list, options)
      end
      
      def cats(options = {})
        @client.seller_cats(self.nick, :cats_list, options)
      end
      
      def shop(options = {})
        @client.shop(self.nick, :shop_info, options)
      end
    end

    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end # LoggedInUserMixin module

  # Location Model
  class Location
    include ModelMixin
    @@ATTRIBUTES = [:zip, :address, :city, :state, :country, :district]
    attr_accessor *@@ATTRIBUTES

    class << self
      def attributes
        @@ATTRIBUTES
      end
    end
  end # Location model

  # UserCredit Model
  class UserCredit
    include ModelMixin
    @@ATTRIBUTES = [:level, :score, :total_num, :good_num]
    attr_accessor *@@ATTRIBUTES

    class << self
      def attributes; @@ATTRIBUTES; end
    end
  end # UserCredit model
  
  # UserSubscribe Model
  class UserSubscribe
    include ModelMixin
    @@ATTRIBUTES = [:status, :start_date, :end_date, :version_no]
    attr_accessor *@@ATTRIBUTES

    class << self
      def attributes; @@ATTRIBUTES; end
    end
  end # UserCredit model

  # User Model
  class User
    include ModelMixin
    @@ATTRIBUTES = [:id, :user_id, :nick, :sex, :avatar, :buyer_credit, :seller_credit, :location, 
      :created, :last_visit, :birthday, :type, :has_more_pic, :item_img_num, :item_img_size, 
      :prop_img_num, :prop_img_size, :auto_repost, :promoted_type, :status, :alipay_bind, 
      :consumer_protection, :alipay_account, :alipay_no, :email, :magazine_subscribe, :vertical_market]
    attr_accessor *@@ATTRIBUTES

    class << self
      def attributes; @@ATTRIBUTES; end

      def default_public_fields
        ["user_id", "nick", "sex", "buyer_credit", "seller_credit", 
          "location.city", "location.state", "email", "location.country", "created", "last_visit", "type"]
      end

      def default_private_fields
        ["location.zip", "birthday", "avatar", "email"]
      end

      def find(u, client)
        client.user(u)
      end
    end

    def bless(client)
      basic_bless(client)
      self.instance_eval(%{
        self.class.send(:include, Top4R::LoggedInUserMixin)
      }) if self.is_me? and not self.respond_to?(:trades)
      self
    end

    def is_me?
      @nick == @client.vistor_nick
    end

    def unmarshal_other_attrs
      @id = @user_id
      if @location && @location.size > 0
        @location = Location.new(@location)
      else
        @location = nil
      end
      @buyer_credit = UserCredit.new(@buyer_credit) if @buyer_credit && @buyer_credit.size > 0
      @seller_credit = UserCredit.new(@seller_credit) if @seller_credit && @seller_credit.size > 0
      # @nick = @nick
      self
    end
  end # User model
end
