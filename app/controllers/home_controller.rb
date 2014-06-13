class HomeController < ApplicationController
  def index
    render layout: 'home'
  end

  def listen_live
    render layout: 'bare'
  end
end
