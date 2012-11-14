class WelcomeController < ApplicationController
  def index
    @blogs = Blog.recent
  end

  def show
  end

  def imprint
  end

end
