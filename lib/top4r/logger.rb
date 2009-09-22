class Top4R::Logger
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
  
  def initialize(logger)
    @logger = logger || Nogger.new
  end
end