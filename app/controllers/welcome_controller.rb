class WelcomeController < ApplicationController
  def index
    @blogposts = BlogPost.recent
  end

  def show
  end

  def imprint
  end

end
