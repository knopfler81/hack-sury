class HomeController < ApplicationController
  def show
    @prospect = Prospect.new

  end
end
