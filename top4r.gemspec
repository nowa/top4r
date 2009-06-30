# Generated: Tue Jun 30 14:24:37 UTC 2009
Gem::Specification.new do |s|
  s.name = "top4r"
  s.version = "0.1.0"
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README","CHANGES","TODO","MIT-LICENSE",]
  s.summary = "TOP4R is a library that can help you build plugin for TaoBao.com quickly in pure Ruby."
  s.author = "Nowa Zhu"
  s.email = "nowazhu@gmail.com"
  s.homepage = "http://top4r.labs.nowa.me"
  s.rubyforge_project = "top4r"
  s.add_dependency("json", ">=1.1.1")
#  s.require_path = "lib"
  s.files = ["lib/top4r/meta.rb","lib/top4r/model.rb","lib/top4r/version.rb","lib/top4r.rb",]
  s.bindir = 'bin'
  s.executables = ['top4rsh']
end
