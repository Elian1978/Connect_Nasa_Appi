require 'uri'
require 'net/http'
require 'json'
#EMPIEZA LA SOLICITUD AL SERVIDOR
def request(url,token = nil)
    url = URI("#{url}&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
  end 

nasa_hash = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&', 'otUrPbYt1tZCNW92894i3JxJ6u6ez9SCVhElufY0')

#ESTRUCTURA DEL NASA_HASH
#{photos [ {"id", "sol", camera{"id", "name", "rover_id", "full_name"}, "img_src", "earth_date", rover{"id", "name", "landing_date", "launch_date", "status"} }]} 
           

completed_photos = nasa_hash["photos"].map {|x| x["img_src"]}
camera_name = nasa_hash["photos"].map {|x| x["camera"]["full_name"]}

#METODO PARA CONTAR LAS FOTOS POR CAMARA
def photos_count(info_count)

        x = info_count.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
        
end 

fotos= photos_count(camera_name)
puts "LAS FOTOS POR TIPOS DE CAMARA SON #{fotos} "

def build_web_page(info_hash)
      image_counter = info_hash.length
      
      File.open('rovers_index.html', 'w') do |file|
                file.puts "<html>\n<head>\n<title>Rovers Nasa!</title>\n</head>"
                file.puts "<body>\n<section class='container'>"
                file.puts "<h1> FOTOGRAFIAS DE LOS ROVERS DE LA NASA CON SUS CARACTERISTICAS</h1>"
                file.puts"<ul>"
                image_counter.times do |i|    
                  file.puts "\t<li><img src='#{info_hash[i]}'width='250'></li>"
                  #file.puts"<li><p> ID DE LA FOTO:  #{info_hash["photos"] [i] ["id"]} </p></li>"
                  #file.puts"<li><p> DIA SOLAR:  #{info_hash["photos"] [i] ["sol"]} </p></li>"
                  #file.puts"<li><p> FECHA TERRESTRE:  #{info_hash["photos"] [i] ["earth_date"]} </p></li>"
                  #file.puts"</ul>"
                end
                file.puts "</ul>\n</section>\n</body>\n<html>"
        end
    end

  puts build_web_page(completed_photos)

 