require 'net/https'
require 'json'

class MakeHttpsRequest
  def call(url, hash_json)
    uri = URI.parse(url)
    req = Net::HTTP::Post.new(uri.to_s)
    req.body = hash_json.to_json
    req['Content-Type'] = 'application/json'
    req['cookie'] = 'librauuid=5oZmuXFmB80ZCg4L; _RGUID=3c2de275-4f2d-4057-893e-fb016a504494; _RSG=N1KBFLdujm3KI4Kg5m..a8; _RDG=28536d57a0bbe82a7219421bb673b78ab3; ibulanguage=TH; ibulocale=th_th; cookiePricesDisplayed=THB; IBU_TRANCE_LOG_P=15589943088; IBU_TRANCE_LOG_URL=/hotels/list?city=622&countryId=4&checkin=2020/08/18&checkout=2020/08/19&optionId=622&optionType=City&directSearch=0&display=%E0%B8%9E%E0%B8%B1%E0%B8%97%E0%B8%A2%E0%B8%B2&crn=1&adult=1&children=0&searchBoxArg=t&travelPurpose=0&ctm_ref=ix_sb_dl&domestic=1; _abtest_userid=b1936a04-233e-4a46-b371-89d0161fe7c1; hotelhst=1164390341; _bfa=1.1597152527689.1qqdl4.1.1597152527689.1597152527689.1.1; _bfs=1.1; _gcl_au=1.1.1124424948.1597152529; _ga=GA1.2.1005104116.1597152529; _gid=GA1.2.782883467.1597152529; _fbp=fb.1.1597152529632.1343444236; _RF1=171.96.90.22; _bfi=p1%3D10320668148%26p2%3D0%26v1%3D1%26v2%3D0; _uetsid=d7876bbedac3b0861f44bd79c2e1b72d; _uetvid=38b27700a644612b9b316e9913e273cf; g_state={"i_p":1597159738156,"i_l":1}'
    req['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36'
    req['referer'] = 'https://th.trip.com/hotels/list?city=622&countryId=4&checkin=2020/08/18&checkout=2020/08/19&optionId=622&optionType=City&directSearch=0&display=%E0%B8%9E%E0%B8%B1%E0%B8%97%E0%B8%A2%E0%B8%B2&crn=1&adult=1&children=0&searchBoxArg=t&travelPurpose=0&ctm_ref=ix_sb_dl&domestic=1'
    
    req['origin'] = 'https://th.trip.com'
    req['p'] = '91387139911'
    req['pid'] = '5180ca0a-6347-42c9-a750-2aad55b34a29'
    
    response = https(uri).request(req)
    response.body
  end

  private

  def https(uri)
    Net::HTTP.new(uri.host, uri.port).tap do |http|
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end
end