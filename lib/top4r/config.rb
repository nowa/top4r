# config.rb contains classes, methods and extends existing TOP4R classes 
# to provide easy configuration facilities.

module TOP4R
  class Config
    include ClassUtilMixin
    @@ATTRIBUTES = [
      :host,
      :user_agent,
      :app_key
    ]
    attr_accessor *@@ATTRIBUTES
    
    # Override of Object#eql? to ensure RSpec specifications run
    # correctly. Also done to follow Ruby best practices.
    def eql?(other)
      return true if self == other
      @@ATTRIBUTES.each do |att|
        return false unless self.send(att).eql?(other.send(att))
      end
      true
    end
  end
  
  class Client
    @@defaults = {
      :host => 'http://gw.sandbox.taobao.com/router/rest',
      :user_agent => "TOP4R",
      :app_key => "12000224"
    }
    @@config = TOP4R::Config.new(@@defaults)
    
    # TOP4R::Client class methods
    class << self
      # Yields to given <tt>block</tt> to configure the TOP4R API.
      def configure(&block)
        raise ArgumentError, "Block must be provided to configure" unless block_given?
        yield @@config
      end # configure
    end # class << self
  end # Client class
end # TOP4R module