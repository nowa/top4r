class TOP4R::Client
  alias :old_inspect :inspect

  def inspect
    s = old_inspect
    s.gsub!(/@password=".*?"/, '@password="XXXX"')
  end
  
  protected
    
end