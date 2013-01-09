### Top4R ###

Top4R封装了 [淘宝开放平台](http://open.taobao.com/ "淘宝开放平台") 的接口，帮助你快速构建基于TOP的应用程序。
目前支持了以下API：

* 商品
* 物流
* 店铺
* 收费
* 淘宝客
* 交易
* 用户

### Get Started ###

配置：

	Top4R::Client.configure do |conf|
		conf.application_name = 'App Name'
		conf.application_version = "1.0.0"
		conf.application_url = 'http//www.example.com'
		conf.test_host = "api.daily.taobao.net"
		conf.env = ((ENV['RAILS_ENV'] != 'development' or force_production) ? :production : :test)
		conf.logger = Rails.logger
		conf.trace = (ENV['RAILS_ENV'] != 'production')
	end

创建一个Top4r::Client：

	$top = Top4R::Client.new(
          :app_key => 'api_key',
          :app_secret => 'api_secret',
          :parameters => nil,
          :session => nil
        )

获取指定id的商品信息：

	item = $top.item(item_id)
	
自定义返回字段：

	item = $top.item(item_id, {:fields => [:title, :price, :cid].join(',))
	
更多文档请到这里查看：

[http://rubydoc.info/gems/top4r/0.2.3/frames](http://rubydoc.info/gems/top4r/0.2.3/frames)

### BY ###

Nowa Zhu (nowazhu@gmail.com)

[http://nowa.me](http://nowa.me)

Thanks Twitter4R <[http://twitter4r.rubyforge.org](http://twitter4r.rubyforge.org)>.

2009-06-22