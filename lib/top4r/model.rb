# Define TOP4R model module

module TOP4R
  # Mixin module for model classes. Includes generic class methods.
  #
  # To create a new model that includes this mixin's features simply:
  # class NewModel
  # include TOP4R::ModelMixin
  # end
  #
  # This mixin module automatically includes <tt>TOP4R::ClassUtilMixin</tt>
  # features.
  # The contract for models to use this mixin correctly is that the class
  # including this mixin must provide an class method named <tt>attributes</tt>
  # that will return an Array of attribute symbols that will be checked
  # in #eql? override method. The following would be sufficient:
  # def self.attributes; @@ATTRIBUTES; end
  module ModelMixin
    module ClassMethods
      
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
    
    def self.included(base)
      base.extend         ClassMethods
      base.send :include, TOP4R::ClassUtilMixin
      base.send :include, InstanceMethods
    end
  end
end