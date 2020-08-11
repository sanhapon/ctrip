class RateController < ApplicationController  

  def search
    @criteria = SearchCriteria.new
  end

  def list
    
    # @hotelList = [
    #   Hotel.new(1, "novotel", 10, 12),
    #   Hotel.new(2, "sofitel", 100, 120),
    #   Hotel.new(3, "novotel", 120, 200),
    # ]

    city = params[:city]
    from = params[:from]
    to = params[:to]
  
    @hotelList = Search.new.getSearchResults(city, from, to)
    @criteria = SearchCriteria.new(city, from, to)
  end
end
