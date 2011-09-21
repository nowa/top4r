# -*- encoding : utf-8 -*-
class Top4R::Logger
  attr_accessor :trace
  
  class << self
    def set_logger(logger)
      self.new logger
    end
  end
  
  class Nogger
    def info(log)
      puts log
    end
  end
  
  def initialize(logger, is_trace = false)
    @trace = is_trace
    @logger = logger || Nogger.new
  end
  
  def info(log)
    @logger.info "top4r trace: #{log}" if @trace
  end
end
