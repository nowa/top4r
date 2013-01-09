# -*- encoding : utf-8 -*-
module Top4R
  module ModelMixin
    module ClassMethods
      def default_public_fields; []; end
      
      def default_private_fields; []; end
      
      # Unmarshal object singular or plural array of model objects
      # from JSON serialization. Currently JSON is only supported.
      def unmarshal(raw)
        # input = JSON.parse(raw)
        input = raw
        # puts "\ninput: #{input.inspect}"
        def unmarshal_model(hash)
          mine = self.new(hash)
          # puts "\n mine: #{mine.inspect}"
          mine.unmarshal_other_attrs if mine.respond_to? :unmarshal_other_attrs
          mine
        end
        return unmarshal_model(input) if input.is_a?(Hash) # singular case
        result = []
        input.each do |hash|
          model = unmarshal_model(hash) if hash.is_a?(Hash)
          result << model
        end if input.is_a?(Array)
        result # plural case
      end
      
      def fields
        (self.default_public_fields + self.default_private_fields).uniq.join(',')
      end
    end
    
    module InstanceMethods
      attr_accessor :client
      
      # Equality method override of Object#eql? default.
      #
      # Relies on the class using this mixin to provide a <tt>attributes</tt>
      # class method that will return an Array of attributes to check are
      # equivalent in this #eql? override.
      #
      # It is by design that the #eql? method will raise a NoMethodError
      # if no <tt>attributes</tt> class method exists, to alert you that
      # you must provide it for a meaningful result from this #eql? override.
      # Otherwise this will return a meaningless result.
      def eql?(other)
        attrs = self.class.attributes
        attrs.each do |att|
          return false unless self.send(att).eql?(other.send(att))
        end
        true
      end
      
      # Returns integer representation of model object instance.
      #
      # For example,
      # product = Top4R::Product.new(:id => 234343)
      # product.to_i #=> 234343
      def to_i
        @id
      end
      
      # Returns hash representation of model object instance.
      #
      # For example,
      # u = Top4R::User.new(:id => 2342342, :screen_name => 'tony_blair_is_the_devil')
      # u.to_hash #=> {:id => 2342342, :screen_name => 'tony_blair_is_the_devil'}
      #
      # This method also requires that the class method <tt>attributes</tt> be
      # defined to return an Array of attributes for the class.
      def to_hash
        attrs = self.class.attributes
        result = {}
        attrs.each do |att|
          value = self.send(att)
          value = value.to_hash if value.respond_to?(:to_hash)
          result[att] = value if value
        end
        result
      end
      
      # "Blesses" model object.
      #
      # Should be overridden by model class if special behavior is expected
      #
      # Expected to return blessed object (usually <tt>self</tt>)
      def bless(client)
        self.basic_bless(client)
      end
      
      protected
        # Basic "blessing" of model object
        def basic_bless(client)
          self.client = client
          self
        end
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, Top4R::ClassUtilMixin
      receiver.send :include, InstanceMethods
    end
  end # ModelMixin module
end

require 'top4r/model/user'
require 'top4r/model/shipping'
require 'top4r/model/trade'
require 'top4r/model/suite'
require 'top4r/model/item'
require 'top4r/model/shop'
require 'top4r/model/taobaokeitem'
require 'top4r/model/itemcat'