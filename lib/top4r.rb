$:.unshift(File.dirname(__FILE__))

require 'rubygems'

module TOP4R; end

# External requires
require('yaml')

require 'top4r/version.rb'
require 'top4r/meta.rb'
require 'top4r/core.rb'
require 'top4r/model.rb'
require 'top4r/config.rb'
require 'top4r/client.rb'