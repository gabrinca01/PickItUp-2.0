class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all
    @awards = Award.all
  end
end
