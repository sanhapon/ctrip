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
    from = params[:from]
    nights = params[:nights]
  
    @hotelList = Search.new.getSearchResults(from, nights)
  end
end
