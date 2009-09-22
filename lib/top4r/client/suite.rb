class Top4R::Client
  @@SUITE_METHODS = {
    :list => 'taobao.suites.get',
  }
  
  def suites(u, service_code, method = :list, options = {}, &block)
    valid_method(method, @@SUITE_METHODS, :suite)
    u = u.nick if u.is_a?(Top4R::User)
    params = {:service_code => service_code}.merge(options).merge(:nick => u)
    response = http_connect {|conn| create_http_get_request(@@SUITE_METHODS[method], params)}
    suites = Top4R::Suite.unmarshal(JSON.parse(response.body)["rsp"]["suite"])
    suites.each {|suite| bless_model(suite); yield suite if block_given?}
    # puts "\nsuites: #{suites.inspect}"
    @total_results = JSON.parse(response.body)["rsp"]["totalResults"].to_i
    suites
  end
end