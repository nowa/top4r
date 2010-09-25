module Top4R::Version
  MAJOR = 0
  MINOR = 1
  REVISION = 0
  
  class << self
    # Returns X.Y.Z formatted version string
    def to_version
      "#{MAJOR}.#{MINOR}.#{REVISION}"
    end

    # Returns X-Y-Z formatted version name
    def to_name
      "#{MAJOR}_#{MINOR}_#{REVISION}"
    end
  end
end