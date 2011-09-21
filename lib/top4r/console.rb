# -*- encoding : utf-8 -*-
require 'optparse'

module Top4R
  class Client
    class << self
      # Helper method mostly for irb shell prototyping.
      #
      # Reads in app_key/app_secret from YAML file
      # found at the location given by <tt>config_file</tt> that has
      # the following format:
      # envname:
      # app_key: application key
      # app_secret: application secret
      # 
      #
      # Where <tt>envname</tt> is the name of the environment like 'test',
      # 'dev' or 'prod'. The <tt>env</tt> argument defaults to 'test'.
      #
      # To use this in the shell you would do something like the following
      # examples:
      # top = Top4R::Client.from_config('config/top.yml', 'dev')
      # top = Top4R::Client.from_config('config/top.yml')
      def from_config(config_file, env = 'test')
        yaml_hash = YAML.load(File.read(config_file))
        self.new yaml_hash[env]
      end
    end # class << self
  end
end
