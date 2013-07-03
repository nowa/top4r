# -*- encoding : utf-8 -*-
# Extension to Hash to create URL encoded string from key-values
class Hash
  # Returns string formatted for HTTP URL encoded name-value pairs.
  # For example,
  # {:id => 'thomas_hardy'}.to_http_str
  # # => "id=thomas_hardy"
  # {:id => 23423, :since => Time.now}.to_http_str
  # # => "since=Thu,%2021%20Jun%202007%2012:10:05%20-0500&id=23423"
  def to_http_str
    result = ''
    return result if self.empty?
    self.each do |key, val|
      result << "#{key}=#{CGI.escape(val.to_s)}&"
    end
    result.chop # remove the last '&' character, since it can be discarded
  end
end
