class Top4R::Client
  alias :old_inspect :inspect
  attr_accessor :total_results
  attr_reader :login
  
  def inspect
    s = old_inspect
    s.gsub!(/@app_secret=".*?"/, '@app_secret="XXXX"')
  end
  
  def init
    total_results = 0
    @@logger = Top4R::Logger.new(@@config.logger, @@config.trace)
    if @parameters and @session
      @parameters = Base64.decode64(@parameters).split('&').inject({}) do |hsh, i| kv = i.split('='); hsh[kv[0]] = kv[1]; hsh end
      @login = user(@parameters['visitor_nick'])
      # puts "login: #{@login.inspect}"
    end
  end
  
  protected
    attr_accessor :app_key, :app_secret, :parameters, :session
    
    def login_required(model, method)
      return if logged_in?
      raise Top4R::LoginRequiredError.new({:model => model, :method => method})
    end
  
    def http_connect(body=nil, &block)
      require_block(block_given?)
      connection = create_http_connection
      connection.start do |connection|
        request = yield connection if block_given?
        # puts "conn: #{connection.inspect}"
        # puts "request: #{request.inspect}"
        response = connection.request(request, body)
        @@logger.info "response: #{response.body}"
        handle_rest_response(response)
        response
      end
    end
    
    # "Blesses" model object with client information
    def bless_model(model)
    	model.bless(self) if model
    end

    def bless_models(list)
      return bless_model(list) if list.respond_to?(:client=)
    	list.collect { |model| bless_model(model) } if list.respond_to?(:collect)
    end
    
  private
    @@http_header = nil
    
    def valid_method(method, methods, model, force_login = false)
      login_required(model, method) if (@@no_login_required_methods[model].is_a?(Hash) and !@@no_login_required_methods[model].keys.member?(method)) or force_login
      raise ArgumentError, "Invalid #{model} method: #{method}" unless methods.keys.member?(method)
    end
    
    def raise_rest_error(response, uri = nil)
      map = JSON.parse(response.body)
      raise Top4R::RESTError.new(:code => response.code,
                                   :message => response.message,
                                   :error => map["error_rsp"],
                                   :uri => uri)
    end
  
    def handle_rest_response(response, uri = nil)
      unless response.is_a?(Net::HTTPSuccess)
        raise_rest_error(response, uri)
      end
      
      map = JSON.parse(response.body)
      if map["error_rsp"].is_a?(Hash) and map["error_rsp"]["code"].to_s == "630"
        @logger.info "Raising SuiteNotOrderedError..."
        raise Top4R::SuiteNotOrderedError.new(:code => map["error_rsp"]["code"],
                                      :message => map["error_rsp"]["msg"],
                                      :error => map["error_rsp"],
                                      :uri => uri)
      else
        @logger.info "Raising RESTError..."
        raise Top4R::RESTError.new(:code => map["error_rsp"]["code"],
                                    :message => map["error_rsp"]["msg"],
                                    :error => map["error_rsp"],
                                    :uri => uri)
      end
    end
  
    def create_http_connection
      protocol, host, port = (@@config.env == :production ? @@config.protocol : @@config.test_protocol), (@@config.env == :production ? @@config.host : @@config.test_host), (@@config.env == :production ? @@config.port : @@config.test_port)
      @@logger.info "Host: #{host}\nPort: #{port}\n"
      conn = Net::HTTP.new(host, port,
                            @@config.proxy_host, @@config.proxy_port,
                            @@config.proxy_user, @@config.proxy_pass)
      if protocol == :ssl
        conn.use_ssl = true
        conn.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      conn
    end
    
    def http_header
      # can cache this in class variable since all "variables" used to
      # create the contents of the HTTP header are determined by other
      # class variables that are not designed to change after instantiation.
      @@http_header ||= {
       'User-Agent' => "Top4R v#{Top4R::Version.to_version} [#{@@config.user_agent}]",
       'Accept' => 'text/x-json',
       'X-TOP-Client' => @@config.application_name,
       'X-TOP-Client-Version' => @@config.application_version,
       'X-TOP-Client-URL' => @@config.application_url,
      }
      @@http_header
    end
    
    def append_top_params(params)
      params = params.merge({
        :session => @session,
        :timestamp => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        :format => "#{@@config.format}",
        :app_key => @app_key,
        :v => "1.0"
      })
      params = params.merge({
        :sign => Digest::MD5.hexdigest(params.sort {|a,b| "#{a[0]}"<=>"#{b[0]}"}.flatten.unshift(@app_secret).join).upcase
      })
    end

    def create_http_get_request(method, params = {})
      uri = @@config.env == :production ? @@config.rest_uri : @@config.test_rest_uri
      params = append_top_params(params.merge({:method => method}))
      path = (params.size > 0) ? "#{uri}?#{params.to_http_str}" : uri
      @@logger.info "path: #{path}"
      Net::HTTP::Get.new(path, http_header)
    end

    def create_http_post_request(uri)
      Net::HTTP::Post.new(uri, http_header)
    end

    def create_http_delete_request(uri, params = {})
      path = (params.size > 0) ? "#{uri}?#{params.to_http_str}" : uri
      Net::HTTP::Delete.new(path, http_header)
    end
end