# -*- encoding : utf-8 -*-
class Top4R::Client
  @@SHOP_METHODS = {
    :cats_list => 'taobao.sellercats.list.get',
    :shop_info => 'taobao.shop.get'
  }
  
  def seller_cats(u, method = :cats_list, options = {}, &block)
    valid_method(method, @@SHOP_METHODS, :shop)
    u = u.nick if u.is_a?(Top4R::User)
    params = options.merge(:nick => u)
    response = http_connect {|conn| create_http_get_request(@@SHOP_METHODS[method], params)}
    result = JSON.parse(response.body)[rsp(@@SHOP_METHODS[method])]
    if result.is_a?(Hash) and result["seller_cats"]
      seller_cats = Top4R::SellerCat.unmarshal(result["seller_cats"]["seller_cat"])
      seller_cats.each {|cat| bless_model(cat); yield cat if block_given?}
    else
      seller_cats = []
    end
    # puts "\nsuites: #{suites.inspect}"
    seller_cats
  end
  
  def shop(u, method = :shop_info, options = {}, &block)
    valid_method(method, @@SHOP_METHODS, :shop)
    u = u.nick if u.is_a?(Top4R::User)
    params = {:fields => Top4R::Shop.fields}.merge(options).merge(:nick => u)
    response = http_connect {|conn| create_http_get_request(@@SHOP_METHODS[method], params)}
    shop = Top4R::Shop.unmarshal(JSON.parse(response.body)[rsp(@@SHOP_METHODS[method])]["shop"])
    bless_model(shop)
  end
end
