class Top4R::Client
  @@AREA_METHODS = {
    :list => 'taobao.areas.get'
  }
  
  @@LOGISTIC_COMPANY_METHODS = {
    :list => 'taobao.logistics.companies.get'
  }
  
  @@DELIVERY_METHODS = {
    :send => 'taobao.delivery.send'
  }
  
  def areas(method = :list, options = {}, &block)
    valid_method(method, @@AREA_METHODS, :area)
    params = {:fields => Top4R::Area.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@AREA_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@AREA_METHODS[method])]
    if result["areas"]
      areas = Top4R::Area.unmarshal(result["areas"]["area"])
      areas.each {|area| bless_model(area); yield area if block_given?}
    else
      areas = []
    end
    areas
  end
  
  def logistic_companies(method = :list, options = {}, &block)
    valid_method(method, @@LOGISTIC_COMPANY_METHODS, :logistic_company)
    params = {:fields => Top4R::LogisticCompany.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@LOGISTIC_COMPANY_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@LOGISTIC_COMPANY_METHODS[method])]
    if result["logistics_companies"]
      logistic_companies = Top4R::LogisticCompany.unmarshal(result["logistics_companies"]["logistics_company"])
      logistic_companies.each {|logistic_company| bless_model(logistic_company); yield logistic_company if block_given?}
    else
      logistic_companies = []
    end
    logistic_companies
  end
  
  def deliver_trade(t, method = :send, options = {})
    valid_method(method, @@DELIVERY_METHODS, :delivery)
    params = {}
    if t.is_a?(Top4R::Delivery)
      params = t.to_hash
    else
      t = t.tid if t.is_a?(Top4R::Trade)
      params = options.merge(:tid => t)
    end
    response = http_connect {|conn| create_http_get_request(@@DELIVERY_METHODS[method], params)}
    json = JSON.parse(response.body)
    json.is_a?(Hash) ? json[rsp(@@DELIVERY_METHODS[method])]["shipping"]["is_success"] : false
  end
end