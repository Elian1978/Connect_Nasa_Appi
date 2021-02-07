require 'uri'
require 'net/http'
require 'json'

def request(url,token = nil)
    url = URI("#{url}?api_key=#{token}") 
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end

#CREAR METODO PARA CREAR LA PAGINA WEB
def build_web_page(info_hash)
    File.open('rovers_index.html', 'w') do |file|
    file.puts "<img src='#{info_hash["url"]}' width ='500'>" 
    #file.puts "<h1> Nombre: '#{info_hash["title"]}</h1>"
    #file.puts "<p> '#{info_hash["explanation"]}</p>"

end

nasa_array = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3', '63puk3DarccswSxeLh16nSVUyDOwnY2Xs2cgZtZV')
puts build_web_page(nasa_array)
puts nasa_array









