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
completed_id = nasa_hash["photos"].map {|x| x["id"]}
earth_date = nasa_hash["photos"].map {|x| x["earth_date"]}
camera_name = nasa_hash["photos"].map {|x| x["camera"]["full_name"]}
rover_status = nasa_hash["photos"].map {|x| x["rover"]["status"]}

#METODO PARA CONTAR LAS FOTOS POR CAMARA
def photos_count(info_count)
   x = info_count.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
end 

fotos= photos_count(camera_name)
puts "LAS FOTOS POR TIPOS DE CAMARA SON #{fotos} "

#METODO PARA LACREACION DE LA WEB_PAGE

def build_web_page(info_hash, id_hash, id_date, id_status)
      image_counter = info_hash.length
      
      File.open('rovers_index.html', 'w') do |file|
                file.puts "<html>\n<head>\n<title>Rovers Nasa!</title>\n</head>"
                file.puts "<body>\n<section class='container'>"
                file.puts "<h1> FOTOGRAFIAS DE LOS ROVERS DE LA NASA CON SUS CARACTERISTICAS</h1>"
                file.puts"<ul>"
                image_counter.times do |i|    
                  file.puts "\t<img src='#{info_hash[i]}'width='250'>"
                  file.puts "\n<li><p> ID is: #{id_hash[i]}</p></li>"
                  file.puts "<li><p>Date in Earth: #{id_date[i]}</p></li>"
                  file.puts "<li><p> Satelite Status: #{id_status[i]}</p></li>"

                  end
                file.puts "</ul>\n</section>\n</body>\n<html>"
        end
    end

  puts build_web_page(completed_photos, completed_id, earth_date, rover_status)
 