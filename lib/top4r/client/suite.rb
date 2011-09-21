# -*- encoding : utf-8 -*-
class Top4R::Client
  @@SUITE_METHODS = {
    :list => 'taobao.suites.get',
  }
  
  def suites(u, service_code, method = :list, options = {}, &block)
    valid_method(method, @@SUITE_METHODS, :suite)
    u = u.nick if u.is_a?(Top4R::User)
    params = {:service_code => service_code}.merge(options).merge(:nick => u)
    response = http_connect {|conn| create_http_get_request(@@SUITE_METHODS[method], params)}
    if response.body == "{\"suites_get_response\":{}}"
      raise Top4R::SuiteNotOrderedError.new(:code => 630,
                                    :message => "没有#{service_code}的订购记录",
                                    :error => "{}",
                                    :uri => @@SUITE_METHODS[method])
    end
    result = JSON.parse(response.body)[rsp(@@SUITE_METHODS[method])]
    if result.is_a?(Hash) and result["suites"]
      suites = Top4R::Suite.unmarshal(result["suites"]["suite"])
      suites.each {|suite| bless_model(suite); yield suite if block_given?}
      @total_results = result["total_results"].to_i
    else
      @total_results = 0
      suites = []
    end
    suites
  end
end
