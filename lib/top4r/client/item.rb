class Top4R::Client
  @@ITEM_METHODS = {
    :onsale_list => 'taobao.items.onsale.get',
    :inventory_list => 'taobao.items.inventory.get',
    :items_list => 'taobao.items.list.get',
    :item => 'taobao.item.get'
  }
  
  def items_onsale(q = nil, method = :onsale_list, options = {}, &block)
    valid_method(method, @@ITEM_METHODS, :item)
    options = {:q => q}.merge(options) if q
    params = {:fields => Top4R::Item.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@ITEM_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@ITEM_METHODS[method])]
    if result.is_a?(Hash) and result['items']
      items = Top4R::Item.unmarshal(result["items"]["item"])
      items.each {|item| bless_model(item); yield item if block_given?}
      @total_results = result["total_results"].to_i
    else
      @total_results = 0
      items = []
    end
    items
  end
  
  # 得到当前会话用户库存中的商品列表
  def items_inventory(q = nil, options = {}, &block)
    method = :inventory_list
    valid_method(method, @@ITEM_METHODS, :item)
    options = {:q => q}.merge(options) if q
    params = {:fields => Top4R::Item.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@ITEM_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@ITEM_METHODS[method])]
    if result.is_a?(Hash) and result['items']
      items = Top4R::Item.unmarshal(result["items"]["item"])
      items.each {|item| bless_model(item); yield item if block_given?}
      @total_results = result["total_results"].to_i
    else
      @total_results = 0
      items = []
    end
    items
  end
  
  # 根据id列表获取宝贝
  # 参数:
  # ids  商品数字id列表，多个num_iid用逗号隔开，一次不超过20个。 如:123456,223456
  def items_list(ids, options = {})
    method = :items_list
    valid_method(method, @@ITEM_METHODS, :item)
    options = {:num_iids => ids}.merge(options)
    params = {:fields => Top4R::Item.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@ITEM_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@ITEM_METHODS[method])]
    if result.is_a?(Hash) and result['items']
      items = Top4R::Item.unmarshal(result["items"]["item"])
      items.each {|item| bless_model(item); yield item if block_given?}
      @total_results = result["total_results"].to_i
    else
      @total_results = 0
      items = []
    end
    items
  end
  
  # 根据id列表获取单个宝贝
  # 参数:
  # id  商品数字id
  def item(id)
    method = :item
    valid_method(method, @@ITEM_METHODS, :item)
    options = {:num_iid => id}.merge({})
    params = {:fields => Top4R::Item.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@ITEM_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@ITEM_METHODS[method])]
    if result.is_a?(Hash) and result['item']
      item = Top4R::Item.unmarshal(result["item"])
    else
      item = nil
    end
    item
  end
end