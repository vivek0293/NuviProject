require "redis"
require "open-uri"
require "json"
require "nokogiri"
require "rubyzip"
begin
    redis = Redis.new(:url => "redis://h:pbnn2v7e09sgt05d7qbaed9sp39@ec2-54-163-236-211.compute-1.amazonaws.com:11909")
    puts "Connected"
    
#    request_uri = 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'
#    request_query = ''
#    url = "#{request_uri}#{request_query}"
#    buffer = open(url).read
#    result = JSON.parse(buffer)
#    #puts result
#    h = {}
#    doc.xpath('//a[@href]').each do |result|
#        h[result.text.strip] = result['href']
#    end
#    puts h

#    page = Nokogiri::HTML(open("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"))
#    links = page.css("a")[5]
#    link = Nokogiri::HTML(open(links))
#    puts link

#page = Nokogiri::HTML(open("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1470862638440.zip"))
##links = page.css("a")[5]
##link = Nokogiri::HTML(open(links))
#puts page

    open('1470862638440.zip', 'wb') do |file|
        file.print open('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1470862638440.zip').read
        Zip::File.open("1470862638440.zip") do |zipfile|
            zipfile.each do |file|
                puts "converted"
                # do something with file
            end
        end
    end
end