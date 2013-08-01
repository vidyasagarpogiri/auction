class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_in_blacklist(user_id, block_id)
  	Blacklist.where(:user_id => user_id, :block_id => block_id).count > 0
  end
end
