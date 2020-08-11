
require 'json'

class SearchCity

  def getHotels(cityId, from, to)
    # url = 'https://th.trip.com/restapi/soa2/16709/json/HotelSearch'
    url = 'https://th.trip.com/restapi/soa2/16709/json/HotelSearch?testab=7fb8f9a7d88f19f9858c4cdd5d5c152bcfd42616ddc5b68a6c4a23bad3b4ba93'
    valid = true
    i = 1
    hotels = []

    while valid do
      search = {
        "searchCondition": {
          "adult": 1,
          "child": 0,
          "pageNo": i,
          "cityId": 622,
          "checkIn": from,
          "checkOut": to,
          "roomNum": 1,
          "pageSize": 10
        },
        "Head": { "Locale": "th-TH", "Currency": "THB" }
      }

      # search = {"seqid":"1fd27268c3fa45ed88b6cce92fedd531","deduplication":[],"filterCondition":{"star":[],"rate":"","priceRange":{"lowPrice":0,"highPrice":-1},"priceType":0,"breakfast":[],"payType":[],"bedType":[],"bookPolicy":[],"bookable":[],"discount":[],"zone":[],"landmark":[],"metro":[],"airportTrainstation":[],"location":[],"cityId":[],"amenty":[],"category":[],"feature":[],"brand":[],"popularFilters":[],"hotArea":[]},"searchCondition":{"sortType":"AppointRank","adult":1,"child":0,"age":"","pageNo":2,"optionType":"City","optionId":"622","lat":0,"destination":"","keyword":"","cityName":"พัทยา","lng":0,"cityId":622,"checkIn":"2020-08-18","checkOut":"2020-08-19","roomNum":1,"mapType":"gg","travelPurpose":0,"countryId":4,"url":"https://th.trip.com/hotels/list?city=622&countryId=4&checkin=2020/08/18&checkout=2020/08/19&optionId=622&optionType=City&directSearch=0&display=%E0%B8%9E%E0%B8%B1%E0%B8%97%E0%B8%A2%E0%B8%B2&crn=1&adult=1&children=0&searchBoxArg=t&travelPurpose=0&ctm_ref=ix_sb_dl&domestic=1","pageSize":10,"timeOffset":25200,"radius":0,"directSearch":0,"signInHotelId":0,"signInType":0},"meta":{"fgt":"","hotelId":"","priceToleranceData":"","priceToleranceDataValidationCode":"","mpRoom":[],"hotelUniqueKey":"","shoppingid":"","minPrice":"","minCurr":""},"queryTag":"NORMAL","Qid":"238375684673","Head":{"Locale":"th-TH","Currency":"THB","AID":"","SID":"","ClientID":"1597152046741.vyghm","OUID":"","CAID":"","CSID":"","COUID":"","TimeZone":"7","PageID":"10320668148","HotelExtension":{"WebpSupport":true,"Qid":"520661426896","hasAidInUrl":false,"group":"TRIP","PID":"2c81c117-38a9-4f07-9962-c4466be458a0","hotelUuidKey":"TqDjO8eqBe0QRnlJpYqTY3dESYsHeBbED8Y4TWOYD4RAPRGbelnjtYU7vOUeg8vzojdYZzrQqJbZvdPjZY0ZyqzYt4ycGjpHvDnWk3YdAjkfyMYO6v71EFOYakw03ySpeQ7iaqY3YLYBDr8ZELmwBzxXHYdUjX4joLWkYOYsNISgWUYApY87i5Zih5iUTjSYcHWG5J9ZYOtwNPvMDyz5YolwOYgbRTAJcovDSyG1RdGJanYONiq6wFfitXizHEHovZY9dJAki1PeBUROBvNNx9Xy0XRl8iZNj9hWOkekpEGLxpFED6I3YS8R3OJHavbfycDRgdJofYSnWHkEcmwUhyDfEHqRqYhFjQMwhdv0Nj8Y5URPoYklj5kWfLeHhj0hWcsW3YdORPBYLHjklWMseGqyh1iZPjOY9tRDOJp1vBAyQXROPJBoYldYL3vZ3YqZiTtw7X","hotelUuid":"5oZmuXFmB80ZCg4L"},"Frontend":{"vid":"1597152046741.vyghm","sessionID":1,"pvid":5},"P":"10272658979","Device":"PC","Version":"0"}}
      result = MakeHttpsRequest.new.call(url,search)      
      list = JSON.parse(result)["Response"]["hotelList"]["list"]
      
      if list == nil
        valid = false
      else
        hotel_list = toHotelList(list)
        hotels.concat(hotel_list)
        i = i + 1 
      end

      if i == 5
        break
      end
    end

    hotels
  end
  
  private 

  def toHotelList(hotelList)
    hotelList.map { |hotel|
      Hotel.new(
        hotel["base"]["hotelId"],
        hotel["base"]["hotelName"],
        hotel["money"]["price"],
        hotel["money"]["afterTaxPrice"]
      )
    }
  end
end