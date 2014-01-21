require 'hpricot'
require 'open-uri'
require 'fileutils'

folder = ARGV[0].split('/').last
FileUtils.mkdir folder

doc = open(ARGV[0]) { |f| Hpricot(f) }

(doc/"img.slide_image").each{ |e|
  location = e.attributes['data-full']
  img = location.split('/').last.split('?').first
  File.open("#{folder}/#{img}", 'wb') do |fo|
    fo.write open(location).read 
  end
  puts "got #{location}"
}

