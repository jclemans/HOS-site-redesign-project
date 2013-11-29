class HomeController < ApplicationController
  def index
    @program_count = Program.active.count
  end
end
