# -*- encoding : utf-8 -*-
$:.unshift(File.dirname(__FILE__))

module Top4R; end

def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end

require 'digest/md5'
require 'net/http'
require 'net/https'
require 'uri'
require 'cgi'
require 'json'
require 'yaml'
require 'timeout'
require 'base64'

require_local('top4r/ext')
require_local('top4r/version')
require_local('top4r/logger')
require_local('top4r/meta')
require_local('top4r/core')
require_local('top4r/model')
require_local('top4r/config')
require_local('top4r/client')
require_local('top4r/console')
