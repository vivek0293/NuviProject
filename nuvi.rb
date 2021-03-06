require "redis"
require "open-uri"
require "json"
require "nokogiri"
require "zip"
begin
    redis = Redis.new(:url => "redis://h:pbnn2v7e09sgt05d7qbaed9sp39@ec2-54-163-236-211.compute-1.amazonaws.com:11909")
    puts "Connected"
    

    a = []
    page = Nokogiri::HTML(open("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"))
    links = page.css("a")
    links.each do |item|
        a.push(item.text)
    end
    #To find the number of zip files
    length = a.length
    
    redis.flushall

    i = 5
    out = []
    puts "Enter Choice as '1' for testCase; '2' for entire data:"
    choice = gets.chomp.to_i
    if choice == 1
        puts"Populating data...."
        while i<=7 do
            open(a[i], 'wb') do |file|
                file.write open('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'+a[i]).read
                Zip::File.open(a[i]) do |zipfile|
                    zipfile.each do |file|
                        xml = zipfile.read(file)
                        doc = Nokogiri::XML(xml)
                        title = doc.at_xpath('//discussion_title').text
                        text = doc.at_xpath('//topic_text').text
                        if out.include?text
                            next
                        else
                            out.push(text)
                            redis.rpush('NEWS_XML',text)
                        end
                        
                    end
                end
            end
            i=i+1
        end
        puts"Insertion Completed"
        output = redis.lrange('NEWS_XML',0,-1)
        #Returns the List Values
        puts output
        #Returns number of items in list
        puts out.length


    elsif choice == 2
        puts"Populating data...."
        while i<=length do
            open(a[i], 'wb') do |file|
                file.write open('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'+a[i]).read
                Zip::File.open(a[i]) do |zipfile|
                    zipfile.each do |file|
                        xml = zipfile.read(file)
                        doc = Nokogiri::XML(xml)
                        title = doc.at_xpath('//discussion_title').text
                        text = doc.at_xpath('//topic_text').text
                        if out.include?text
                            break
                        else
                            out.push(text)
                            redis.rpush('NEWS_XML',text)
                        end

                        
                    end
                end
            end
            i=i+1
        end
        puts"Insertion Completed"
        output = redis.lrange('NEWS_XML',0,-1)
        #Returns the List Values
        puts output
        #Returns number of items in list
        puts out.length




    else
        puts"Invalid Choice"
    end
end
