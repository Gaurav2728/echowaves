class HomeController < ApplicationController
  def ssl_required?
    true if USE_SSL
  end

  # just a homepage
  def index
    @users = User.active.find(:all, :order => 'created_at DESC', :limit => 24)
    @recent_convos = Conversation.non_private.find(:all, :order => 'created_at DESC', :limit => 5)
    @popular_convos = Conversation.non_private.most_popular
    @total_convos = Conversation.count
    @total_messages = Message.published.count
    @total_users = User.active.count
    @home_convo = Conversation.find_by_id(HOME_CONVERSATION)
    @test_convo = Conversation.find_by_id(TEST_CONVERSATION)
  end

  def terms
  end

  def toggle_sound
    session[:sound] = (session[:sound] == "on" ? "off" : "on")
    redirect_to :back
  end
end
