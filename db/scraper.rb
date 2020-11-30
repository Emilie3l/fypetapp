require 'open-uri'
require 'nokogiri'

url = "https://ayudandopatitas.com/cdmx/"

html_file = open(url).read
response = Nokogiri::HTML(html_file)

response.search('.post-excerpt').each do |element|
  description = element.search('.descripcion-corta').text
  location = element.search('.font11').text.squeeze(" ").gsub("\n",'').strip.split(",")[2..-1].join
  picture = element.search('.lazy').text
  month = element.search('.month').text.squeeze(" ").gsub("\n",'')
  day = element.search('.day').text.squeeze(" ").gsub("\n",'').strip.split(",").join
  year = element.search('.year').text.squeeze(" ").gsub("\n",'').strip.split(",").join
  date = "#{day}#{month}#{year}"
  Report.create(traits: description, date: date, address: location)
end
