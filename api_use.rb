require 'uri'
require 'net/http'
require 'json'

url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=otUrPbYt1tZCNW92894i3JxJ6u6ez9SCVhElufY0")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
puts response.read_body
