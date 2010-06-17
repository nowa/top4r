class Top4R::Client
  include Top4R::ClassUtilMixin
  
  @@no_login_required_methods = {
    :user => {
      :info => 'taobao.user.get',
      :multi_info => 'taobao.users.get'
    },
    :trade => {},
    :area => {
      :list => 'taobao.areas.get'
    },
    :logistic_company => {
      :list => 'taobao.logisticcompanies.get'
    },
    :shop => {
      :cats_list => 'taobao.sellercats.list.get', 
      :shop_info => 'taobao.shop.get'      
    },
    :item => {},
    :taobaoke_item => {}
  }
end

require 'top4r/client/base'
require 'top4r/client/user'
require 'top4r/client/shipping'
require 'top4r/client/trade'
require 'top4r/client/suite'
require 'top4r/client/item'
require 'top4r/client/shop'