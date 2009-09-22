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
    }
  }
end

require 'top4r/client/base'
require 'top4r/client/user'
require 'top4r/client/shipping'
require 'top4r/client/trade'
require 'top4r/client/suite'