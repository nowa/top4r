# -*- encoding : utf-8 -*-
class Top4R::Client
  alias item_info item
  alias items_info items_list

  @@ITEM_METHODS = {
    :inventory_list => 'taobao.items.inventory.get',
    :onsale_list => 'taobao.items.onsale.get', 
    :item_info => 'taobao.item.get', 
    :items_info => 'taobao.items.list.get', 
    :item_skus => 'taobao.item.skus.get', 
    :search => 'taobao.items.get'
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
  
  def item_info(iid = nil, options = {}, &block)
    method = :item_info
    valid_method(method, @@ITEM_METHODS, :item)
    options = {:num_iid => iid}.merge(options) if iid
    params = {:fields => Top4R::Item.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@ITEM_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@ITEM_METHODS[method])]
    if result.is_a?(Hash) and result['item']
      item = Top4R::Item.unmarshal(result["item"])
      item = bless_model(item)
    else
      item = nil
    end
    item
  end

  def items_info(iid = nil, options = {}, &block)
    method = :items_info
    valid_method(method, @@ITEM_METHODS, :item)
    # 为了兼容老的items_list接口，先split，后面再join
    iid = iid.split(',') if !iid.is_a?(Array)
    options = {:num_iids => iid.join(',')}.merge(options) if iid
    params = {:fields => Top4R::Item.fields}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@ITEM_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@ITEM_METHODS[method])]
    if result.is_a?(Hash) and result['items']
      items = Top4R::Item.unmarshal(result["items"]["item"])
      items.each {|item| bless_model(item); yield item if block_given?}
      @total_results = items.size
    else
      @total_results = 0
      items = []
    end
    items
  end
end
