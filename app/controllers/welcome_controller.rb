class WelcomeController < ApplicationController

  respond_to :html, :json

  def index
    @blogposts = BlogPost.recent
  end

  def show
  end

  def imprint
  end

end
