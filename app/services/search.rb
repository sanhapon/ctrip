require 'json'
# require_relative 'MakeHttpsRequest'

class Search

  def getSearchResults(from, to) 
    url = "https://th.trip.com/hotels/list?city=622&countryId=4&checkin=#{from}&checkout=#{to}&directSearch=0&crn=1&adult=1&children=0&searchBoxArg=t&travelPurpose=0&ctm_ref=ix_sb_dl&domestic=1"
    hotel_list = getCitySearchResults(url)
    hotel_price_list = getHotelPrice(hotel_list)
    
    formatResult(hotel_list, hotel_price_list)
  end

  private

  def getCitySearchResults(url)
    result = MakeHttpsRequest.new.call(url,{})
    from = result.index('window.IBU_HOTEL')
    to = result.index('__webpack_public_path__')
    json_str = result[from + 17 .. to-7].force_encoding('UTF-8') 
    json_obj = JSON.parse(json_str) 

    json_obj["initData"]["firstPageList"]["hotelList"]["list"].map { |hotel|
      { hotelId: hotel["base"]["hotelId"],
        hotelName: hotel["base"]["hotelName"],
        realPrice: hotel["money"]["price"],
        afterTaxPrice: hotel["money"]["afterTaxPrice"]
      }
    }
  end

  def getHotelPrice(hotel_list)
    post_data = { list: hotel_list.map { |hotel| 
      {hotelId: hotel[:hotelId], realPrice: hotel[:realPrice], afterTaxPrice: hotel[:afterTaxPrice]}
    }}
    result = MakeHttpsRequest.new.call('https://th.trip.com/restapi/soa2/16709/json/hote1search', post_data)
    JSON.parse(result)["Response"]["list"]
  end

  def formatResult(hotel_list, hotel_price_list) 
    hotel_list.map { |hotel|
      Hotel.new(
        hotel[:hotelId],
        hotel[:hotelName],
        hotel_price_list.find { |e| e["hotelId"] == hotel[:hotelId].to_s}["realPrice"], 
        hotel_price_list.find { |e| e["hotelId"] == hotel[:hotelId].to_s}["afterTaxPrice"]
      )
    }
  end
end
