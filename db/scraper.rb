require 'open-uri'
require 'nokogiri'
require 'csv'

url = "https://ayudandopatitas.com/cdmx/"

html_file = open(url).read
response = Nokogiri::HMTL(html_file)

response.search('.post-excerpt').each do |element|
  description = element.search('.descripcion-corta')
  location = element.search('.font11')
  picture = element.search('.lazy')
  month = element.search('.month')
  day = element.search('.day')
  year = element.search('.year')
  date = "#{day}#{month}#{year}"
  post = "#{description}#{date}#{location}"
  puts post.text
end

  Post.create(traits: description, date: date, address: location)




[12] pry(main)> parsed_html.search('.post-excerpt').each do |post|
[12] pry(main)*   post.search('.date')
[12] pry(main)*   description = post.search('.description')
[12] pry(main)*   Post.create(info: description, date: date)
[12] pry(main)*   mont = post.search('.month')
[12] pry(main)*   "#{day}#{month}#{year}"
