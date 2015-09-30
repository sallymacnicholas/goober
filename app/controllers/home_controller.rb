class HomeController < ApplicationController
  def index
  end

  def not_found
    redirect_to root_path
  end
end
