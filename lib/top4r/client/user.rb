class Top4R::Client
  @@USER_METHODS = {
    :info => 'taobao.user.get',
    :multi_info => 'taobao.users.get'
  }
  
  def logged_in?
    @login.is_a?(Top4R::User) ? true : false
  end
  
  def user(u, method = :info, options = {})
    valid_method(method, @@USER_METHODS, :user)
    u = u.nick if u.is_a?(Top4R::User)
    users = user_request(u, method, options)
    method == :info ? bless_model(users.first) : bless_models(users)
  end
  
  def my(method, options = {})
    valid_method(method, @@USER_METHODS, :user, true)
    users = user_request(@login.nick, method, options)
    method == :info ? bless_model(users.first) : bless_models(users)
  end
  
  protected
  
    def user_request(u, method, options)
      @@logger.info "u: #{u}"
      params = {:fields => Top4R::User.fields}.merge(options).merge((method == :info ? :nick : :nicks) => u)
      response = http_connect {|conn| create_http_get_request(@@USER_METHODS[method], params)}
      @@logger.info "rsp: #{rsp(@@USER_METHODS[method])}"
      
      if method == :info
        return [Top4R::User.unmarshal(JSON.parse(response.body)[rsp(@@USER_METHODS[method])]["user"])]
      else
        return Top4R::User.unmarshal(JSON.parse(response.body)[rsp(@@USER_METHODS[method])]["users"]["user"])
      end
    end
end