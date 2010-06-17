class Top4R::Client
  @@TAOBAOKEITEM_METHODS = {
    :taobaoke_items_get => 'taobao.taobaoke.items.get'
  }
  
  def taobaoke_items(q = nil, method = :taobaoke_items_get, options = {}, &block)
    valid_method(method, @@TAOBAOKEITEM_METHODS, :taobaoke_item)
    options = {:keyword => q}.merge(options) if q
    params = {:fields => Top4R::TaobaokeItem.fields, :v => "2.0"}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@TAOBAOKEITEM_METHODS[method], params)}
    
    items = Top4R::TaobaokeItem.unmarshal(JSON.parse(response.body)["taobaoke_items_get_response"]["taobaoke_items"])
    items.each {|item| bless_model(item); yield item if block_given?}
    @total_results = JSON.parse(response.body)["taobaoke_items_get_response"]["total_results"].to_i
    items
  end
end