class RateController < ApplicationController  

  def search
    @criteria = SearchCriteria.new
  end

  def list
    city = params[:city]
    from = params[:from]
    to = params[:to]
  
    # @hotelList = Search.new.getSearchResults(city, from, to)
    @hotelList = SearchCity.new.getHotels(city, from, to)
    @criteria = SearchCriteria.new(city, from, to)
  end
end
