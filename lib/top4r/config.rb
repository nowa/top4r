module Top4R
  # A rails like config object
  class Config
    include ClassUtilMixin
    @@ATTRIBUTES = [
        :env,
        :host,
        :rest_uri,
        :port,
        :protocol,
        :test_host,
        :test_rest_uri,
        :test_port,
        :test_protocol,
        # :staging_host,
        #         :staging_rest_uri,
        #         :staging_port,
        #         :staging_protocol,
        :proxy_host,
        :proxy_port,
        :proxy_user,
        :proxy_pass,
        :format,
        :application_name,
        :application_key,
        :application_secret,
        :application_version,
        :application_url,
        :user_agent,
        :source,
        :logger,
        :trace
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
  end # Config class
  
  class Client
    @@defaults = {
      :env => :test,
      :host => 'gw.api.taobao.com',
      :rest_uri => '/router/rest',
      :port => 80,
      :protocol => :http,
      :test_host => 'gw.sandbox.taobao.com',
      :test_rest_uri => '/router/rest',
      :test_port => 80,
      :test_protocol => :http,
      # :staging_host => '192.168.208.110',
      #       :staging_rest_uri => '/top/private/services/rest',
      #       :staging_port => '8080',
      #       :staging_protocol => :http,
      :proxy_host => nil,
      :proxy_port => nil,
      :format => :json,
      :application_name => 'Top4R',
      :application_key => '12000224',
      :application_secret => '2f26cb1a99570aa72daee12a1db88e63',
      :application_version => Top4R::Version.to_version,
      :application_url => 'http://top4r.nowa.me',
      :user_agent => 'default',
      :source => 'top4r',
      :logger => nil,
      :trace => false
    }
    @@config = Top4R::Config.new(@@defaults)
    @@logger = Top4R::Logger.new(@@config.logger)
    
    # Top4R::Client class methods
    class << self
      # Yields to given <tt>block</tt> to configure the Twitter4R API.
      def configure(&block)
        raise ArgumentError, "Block must be provided to configure" unless block_given?
        yield @@config
      end # configure
    end # class << self
  end # Client class
end