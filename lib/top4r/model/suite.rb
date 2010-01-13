module Top4R
  # Suite model
  class Suite
    include ModelMixin
    @@ATTRIBUTES = [:id, :nick, :suite_name, :start_date, :end_date]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end
    end
    
    def unmarshal_other_attrs
      self
    end
  end
end