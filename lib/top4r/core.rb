# The TOP4R API provides a nicer Ruby object API to work with 
# instead of coding around the open.taobao.com API.

# Module to encapsule the TOP4R API.
module TOP4R
  # Mixin module for classes that need to have a constructor similar to
  # Rails' models, where a <tt>Hash</tt> is provided to set attributes
  # appropriately.
  # 
  # To define a class that uses this mixin, use the following code:
  #  class FilmActor
  #    include ClassUtilMixin
  #  end
  module ClassUtilMixin
    module ClassMethods
      
    end
    
    # Instance methods defined for <tt>TOP4R::ModelMixin</tt> module.
    module InstanceMethods
      # Constructor/initializer that takes a hash of parameters that 
      # will initialize *members* or instance attributes to the 
      # values given.  For example,
      # 
      #  class FilmActor
      #    include TOP4R::ClassUtilMixin
      #    attr_accessor :name
      #  end
      #  
      #  class Production
      #    include TOP4R::ClassUtilMixin
      #    attr_accessor :title, :year, :actors
      #  end
      #  
      #  # Favorite actress...
      #  jodhi = FilmActor.new(:name => "Jodhi May")
      #  jodhi.name # => "Jodhi May"
      #  
      #  # Favorite actor...
      #  robert = FilmActor.new(:name => "Robert Lindsay")
      #  robert.name # => "Robert Lindsay"
      #  
      #  # Jane is also an excellent pick...gotta love her accent!
      #  jane = FilmActor.new(name => "Jane Horrocks")
      #  jane.name # => "Jane Horrocks"
      #  
      #  # Witty BBC series...
      #  mrs_pritchard = Production.new(:title => "The Amazing Mrs. Pritchard", 
      #                                 :year => 2005, 
      #                                 :actors => [jodhi, jane])
      #  mrs_pritchard.title  # => "The Amazing Mrs. Pritchard"
      #  mrs_pritchard.year   # => 2005
      #  mrs_pritchard.actors # => [#<FilmActor:0xb79d6bbc @name="Jodhi May">, 
      #  <FilmActor:0xb79d319c @name="Jane Horrocks">]
      #  # Any Ros Pritchard's out there to save us from the Tony Blair
      #  # and Gordon Brown *New Labour* debacle?  You've got my vote! 
      #  
      #  jericho = Production.new(:title => "Jericho", 
      #                           :year => 2005, 
      #                           :actors => [robert])
      #  jericho.title   # => "Jericho"
      #  jericho.year    # => 2005
      #  jericho.actors  # => [#<FilmActor:0xc95d3eec @name="Robert Lindsay">]
      # 
      # Assuming class <tt>FilmActor</tt> includes 
      # <tt>TOP4R::ClassUtilMixin</tt> in the class definition 
      # and has an attribute of <tt>name</tt>, then that instance 
      # attribute will be set to "Jodhi May" for the <tt>actress</tt> 
      # object during object initialization (aka construction for 
      # you Java heads).
      def initialize(params = {})
        params.each do |key,val|
          self.send("#{key}=", val) if self.respond_to? key
        end
        self.send(:init) if self.respond_to? :init
      end
      
      protected
        # Helper method to provide an easy and terse way to require 
        # a block is provided to a method.
        def require_block(block_given)
          raise ArgumentError, "Must provide a block" unless block_given
        end
    end
    
    def self.included(base)
      base.extend         ClassMethods
      base.send :include, InstanceMethods
    end
  end
end