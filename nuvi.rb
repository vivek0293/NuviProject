require "redis"
require "open-uri"
require "json"
require "nokogiri"
require "zip"
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

    open('1470866577151.zip', 'wb') do |file|
        file.print open('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1470866577151.zip').read
        Zip::File.open("1470866577151.zip") do |zipfile|
            zipfile.each do |file|
                file = file.to_s
                puts file
                xml_file = Nokogiri::XML(IO.read("ad9a377b8483ba0f16ae2d52bbb4831d.xml"))
#                page = Nokogiri::XML(open(file))
                #doc = File.open(file) { |f| Nokogiri::XML(f) }
                puts xml_file
                # do something with file
            end
        end
    end
end