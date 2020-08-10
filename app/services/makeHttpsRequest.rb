require 'net/https'
require 'json'

class MakeHttpsRequest
  def call(url, hash_json)
    uri = URI.parse(url)
    req = Net::HTTP::Post.new(uri.to_s)
    req.body = hash_json.to_json
    req['Content-Type'] = 'application/json'
    req['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36'

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