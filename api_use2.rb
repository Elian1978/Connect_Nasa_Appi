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

#CONVIERTO EL NASA_HASH A UN ARRAY
#new_array = nasa_hash.collect{ |key, value|} 


puts "*************************************"


def web_page_nasa(info_hash)
    File.open('rovers_index.html', 'w') do |file|
        file.puts "<h1> FOTOGRAFIAS DE LOS ROVERS DE LA NASA CON SUS CARACTERISTICAS</h1>"
       for i in (1..10) do
            info_hash.each do |element|
            
            file.puts "<img src='#{info_hash["photos"][i] ["img_src"]}' width ='250px'>" 
            file.puts "<p> ID DE LA FOTO:  #{info_hash["photos"] [i] ["id"]} </p>"
            file.puts "<p> DIA SOLAR:  #{info_hash["photos"] [i] ["sol"]} </p>"
            file.puts "<p> DIA SOLAR:  #{info_hash["photos"] [i] ["sol"]} </p>"      
            #file.puts "<p> CAMARA:  #{info_hash["photos"] []} #{info_hash["camera"] [0] }["id"]} </p>"

            #{camera["id", "name", "rover_id", "full_name"]} 
            #{element["images"]["main"]}' '>"
            file.puts "<p> FECHA TERRESTRE:  #{info_hash["photos"] [i] ["earth_date"]} </p>"
        end
      end
    end
  end
  
puts web_page_nasa(nasa_hash)