Gem::Specification.new do |s|
  s.name = %q{top4r}
  s.version = "0.0.1"
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.markdown", "README", "CHANGES", "TODO",]
  s.summary = %q{TOP4R is a library that can help you build plugin for TaoBao.com quickly.}
  s.authors = ['Nowa Zhu']
  s.date = %q{2009-06-22}
  s.email = ['nowazhu@gmail.com']
  s.homepage = %q{http://top4r.labs.nowa.me}
  s.rubyforge_project = %q{top4r}
  # s.add_dependency(%q<hoe>, [">= 1.5.3"])
  
  s.files = ["lib/top4r.rb"]
  s.bindir = 'bin'
  s.executables = ['top4r']
  s.default_executable = %q{top4r}
  s.require_paths = ["lib"]
  s.rdoc_options = ["--main", "README.markdown"]
end