class Top4R::Client
  @@TRADE_METHODS = {
    :bought_list => 'taobao.trades.bought.get',
    :sold_list => 'taobao.trades.sold.get',
    :increments_list => 'taobao.trades.sold.increment.get',
    :info => 'taobao.trade.get',
    :fullinfo => 'taobao.trade.fullinfo.get',
    :close => 'taobao.trade.close',
    :add_memo => 'taobao.trade.memo.add',
    :update_memo => 'taobao.trade.memo.update',
    :confirmfee => 'taobao.trade.confirmfee.get'
  }
  
  def trades_for(method = :bought_list, options = {}, &block)
    valid_method(method, @@TRADE_METHODS, :trade)
    params = {:fields => Top4R::Trade.fields}.merge(options)
    if method == :increments_list
      now = Time.now
      params = {:start_modified => (now - 24.hours).strftime("%Y-%m-%d %H:%M:%S"), :end_modified => now.strftime("%Y-%m-%d %H:%M:%S")}.merge(params)
    end
    response = http_connect {|conn| create_http_get_request(@@TRADE_METHODS[method], params)}
    trades = Top4R::Trade.unmarshal(JSON.parse(response.body)[rsp(@@TRADE_METHODS[method])]["trades"]["trade"])
    trades.each {|trade| bless_model(trade); yield trade if block_given?}
    # puts "\ntrades: #{trades.inspect}"
    @total_results = JSON.parse(response.body)[rsp(@@TRADE_METHODS[method])]["total_results"].to_i
    trades
  end
  
  def trade(t, method = :info, options = {})
    valid_method(method, @@TRADE_METHODS, :trade)
    t = t.tid if t.is_a?(Top4R::Trade)
    params = {:fields => Top4R::Trade.fields}.merge(options).merge(:tid => t)
    response = http_connect {|conn| create_http_get_request(@@TRADE_METHODS[method], params)}
    parsed_body = JSON.parse(response.body)
    
    if [:info, :fullinfo].member?(method)
      trades = Top4R::Trade.unmarshal(parsed_body[rsp(@@TRADE_METHODS[method])]["trade"])
      bless_model(trades.first)
    elsif method == :confirmfee
      confirmfees = Top4R::TradeConfirmFee.unmarshal(parsed_body[rsp(@@TRADE_METHODS[method])]["trade_confirm_fee"])
      bless_models(confirmfees)
    elsif [:close, :update_memo].member?(method)
      parsed_body[rsp(@@TRADE_METHODS[method])]["trade"]["modified"]
    elsif method == :add_memo
      parsed_body[rsp(@@TRADE_METHODS[method])]["trade"]["created"]
    end
  end
end