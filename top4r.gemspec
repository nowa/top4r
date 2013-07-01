# Generated: 2011-12-28 02:43:59 UTC
Gem::Specification.new do |s|
  s.name = "top4r"
  s.version = "0.2.3"
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.textile","CHANGES","TODO","MIT-LICENSE",]
  s.summary = "TOP4R is a library that can help you build plugin for TaoBao.com quickly in pure Ruby."
  s.author = "Nowa Zhu"
  s.email = "nowazhu@gmail.com"
  s.homepage = "https://github.com/nowa/top4r"
  s.rubyforge_project = "top4r"
  s.add_dependency("json", ">=1.1.1")
  s.add_dependency("string_utf8", ">=0.0.1")
#  s.require_path = "lib"
  s.files = ["lib/top4r/client/base.rb","lib/top4r/client/item.rb","lib/top4r/client/shipping.rb","lib/top4r/client/shop.rb","lib/top4r/client/suite.rb","lib/top4r/client/taobaokeitem.rb","lib/top4r/client/itemcat.rb","lib/top4r/client/trade.rb","lib/top4r/client/user.rb","lib/top4r/client.rb","lib/top4r/config.rb","lib/top4r/console.rb","lib/top4r/core.rb","lib/top4r/ext/stdlib.rb","lib/top4r/ext.rb","lib/top4r/logger.rb","lib/top4r/meta.rb","lib/top4r/model/item.rb","lib/top4r/model/shipping.rb","lib/top4r/model/shop.rb","lib/top4r/model/suite.rb","lib/top4r/model/taobaokeitem.rb","lib/top4r/model/itemcat.rb","lib/top4r/model/trade.rb","lib/top4r/model/user.rb","lib/top4r/model.rb","lib/top4r/version.rb","lib/top4r.rb",]
  s.bindir = 'bin'
  s.executables = ['top4rsh']
end
