# -*- encoding : utf-8 -*-
class Top4R::Client
  @@ITEMCAT_METHODS = {
    :cats_info => 'taobao.itemcats.get',
  }
  
  def itemcats(cids, options = {}, &block)
    method = :cats_info
    valid_method(method, @@ITEMCAT_METHODS, :item_cat)
    cids = [cids] if !cids.is_a?(Array)
    params = {:cids => cids.join(',')}.merge(options)
    response = http_connect {|conn| create_http_get_request(@@ITEMCAT_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@ITEMCAT_METHODS[method])]
    if result.is_a?(Hash) and result["item_cats"]
      item_cats = Top4R::ItemCat.unmarshal(result["item_cats"]["item_cat"])
      item_cats.each {|cat| bless_model(cat); yield cat if block_given?}
    else
      item_cats = []
    end
    # puts "\nsuites: #{suites.inspect}"
    item_cats
  end
end
