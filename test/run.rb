#!/usr/bin/env ruby

def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end

require 'rubygems'
require 'sinatra'
require_local('../lib/top4r')

get '/' do
  Top4R::Client.configure do |conf|
    conf.application_name = 'Top4R'     
    conf.application_version = "0.1.0"
    conf.application_url = 'http//top4r.labs.nowa.me'
    conf.env = :test
    conf.trace = true
  end
  
  @top = Top4R::Client.new(
    :app_key => '12000224',
    :app_secret => '2f26cb1a99570aa72daee12a1db88e63',
    :parameters => params['top_parameters'], 
    :session => params['top_session']
  )
  
  erb :index
end