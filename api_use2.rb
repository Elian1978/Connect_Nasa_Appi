require 'uri'
require 'net/http'
require 'json'

def request(url,token = nil)
    url = URI("#{url}&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end 
nasa_hash = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&', 'otUrPbYt1tZCNW92894i3JxJ6u6ez9SCVhElufY0')
puts nasa_hash

#CONVIERTO EL NASA_HASH A UN ARRAY

def web_page_nasa(info_hash)

    File.open('rovers_index.html', 'w') do |file|
        file.puts "<img src='#{info_hash["photos"] [1] ["img_src"]}' width ='500'>" 
        file.puts "<p> ID DE LA FOTO:  #{info_hash["photos"] [1] ["id"]} </p>"
        file.puts "<p> DIA SOLAR:  #{info_hash["photos"] [1] ["sol"]} </p>"
        file.puts "<p> FECHA TERRESTRE:  #{info_hash["photos"] [1] ["earth_date"]} </p>"
    #file.puts "<h1> Nombre: '#{info_hash["title"]}</h1>"
    #file.puts "<p> '#{info_hash["explanation"]}</p>"
    end
end


puts web_page_nasa(nasa_hash)


