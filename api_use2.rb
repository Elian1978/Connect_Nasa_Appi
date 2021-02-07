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

nasa_hash = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100&', 'otUrPbYt1tZCNW92894i3JxJ6u6ez9SCVhElufY0')

#CONVIERTO EL NASA_HASH A UN ARRAY
#new_array = nasa_hash
puts nasa_hash.class
puts nasa_hash.size



#new_array = nasa_hash.collect{ |key, value|} 

puts nasa_hash.class
puts "*******IMPRIMO ARRAY**********************"

#CREACION METODO PAGINA WEB


string_html = '''<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <title>ROVERS DE LA NASA</title>
  </head>
  <body>
    <h1>FOTOGRAFIAS DE LOS ROVERS DE LA NASA CON SUS CARACTERISTICAS</h1>
    <ul>ROVERS Y SUS CARACTERISTICAS

    '''
    def build_web_page(info_hash)
      
        File.open('rovers_index.html', 'w') do |file|
          
          file.puts "<h1> FOTOGRAFIAS DE LOS ROVERS DE LA NASA CON SUS CARACTERISTICAS</h1>"
         for i in (1..10) do
          
              info_hash.each do |element|    


                file.puts"<ul>"
                file.puts"<img src='#{info_hash["photos"][i] ["img_src"]}' width ='200px' text_center>"
                file.puts"<li><p> ID DE LA FOTO:  #{info_hash["photos"] [i] ["id"]} </p></li>"
                file.puts"<li><p> DIA SOLAR:  #{info_hash["photos"] [i] ["sol"]} </p></li>"
                file.puts"<li><p> FECHA TERRESTRE:  #{info_hash["photos"] [i] ["earth_date"]} </p></li>"
                file.puts"</ul>"
            
              #file.puts "<p> CAMARA:  #{info_hash["photos"] []} #{info_hash["camera"] [0] }["id"]} </p>"
              #file.puts "<p> DIA SOLAR:  #{info_hash["photos"]["sol"]} </p>"
              
              #ESTRUCTURA DEL NASA_HASH
              #{photos [ {"id", "sol", camera{"id", "name", "rover_id", "full_name"}, "img_src", "earth_date", rover{"id", "name", "landing_date", "launch_date", "status"} }]} 
              #{info_hash["photos"]  ME DEVUELVE TODO EL ARREGLO FOTOS
              #{info_hash["photos"] [i] ["id"]} ME DEVUELVE ID DE LA FOTO
              #file.puts "<p> ID DE CAMARA: #{info_hash["photos"] [0]} #{info_hash["camera"] ["id"]}  </p>"
              
              #file.puts "<p> ID: #{info_hash["photos"] [i] ["id"]} </p>"

              #file.puts "<p> ID: #{info_hash["photos"][1] ["camera"]} </p>"
              #file.puts "<p> ID: #{info_hash["camera"] [1] ["id"]} </p>"
              

              
              
          end
        end
      end
      
    end
    
  puts build_web_page(nasa_hash)

    string_html += '''

        <ul><script>#{info_hash["photos"] [i] ["sol"]}</script></ul>
        <ul>Segundo Dato</ul>
        <ul>TercerDato</ul>
    </ul>
    
   
    
    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    -->
  </body>
</html>
'''

fHTML = File.open("final.html","w")
fHTML.write(string_html)
fHTML.close