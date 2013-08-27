#encoding: utf-8
class Sendmail < ActionMailer::Base
  default from: "auction@example.com"

  def deal_new( receiver, product, deal )
  	@deal = deal
    @product = product

    #提供匯款資訊
  	mail(:to => [ receiver, @product.useremail, "kobanae@summers.com.tw" ], :subject => "新交易(#{ @deal.serialnum })成立通知")
  end

  def deal_status_change( receiver, deal )
  	@deal = deal

  	mail(:to => [ receiver, "kobanae@summers.com.tw" ], :subject => "交易(#{ @deal.serialnum })狀態變更為#{ @deal.status }")
  end

  def dealask_new( receiver, dealask )
  	@dealask = dealask

  	mail(:to => [ receiver, "kobanae@summers.com.tw" ], :subject => "交易(#{ @dealask.serialnum })有新留言")
  end

  def dealvalue_new( receiver, dealvalue )
  	@dealvalue = dealvalue

  	mail(:to => [ receiver, "kobanae@summers.com.tw" ], :subject => "交易(#{ @dealvalue.serialnum })有新評價")
  end

  def productask_new( receiver, productname, productask )
  	@productask = productask
    @productname = productname

  	mail(:to => [ receiver, "kobanae@summers.com.tw" ], :subject => "商品#{ @productname }有新提問")
  end

  def productaskre_new( receiver, productask, productaskre )
  	@productask = productask
    @productaskre = productaskre

  	mail(:to => [ receiver, "kobanae@summers.com.tw" ], :subject => "賣家回答了你對商品#{ @productaskre.productname }的發問")
  end
end