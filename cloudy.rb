#	Project: lastfm/cloudy
#	Version: 0.2
#	Date: 21.02.2010
#	Author: Krystian Koscielniak (ian992/carmaris)
#	Summary: With cloudy you can easily create cloud of your favourite artists on your last.fm profile.

require File.expand_path(File.dirname(__FILE__) + "/lib/cloudy.rb")
require "optparse"

version = 0.2

options = {}

optparse = OptionParser.new do |opts|
	opts.banner = "Usage: cloudy [user] [options]"	
	@usage = opts
    opts.on('-h', '--help', 'Displays this screen.') do
    	puts opts
    	exit
    end

    options[:user] = ARGV.first

	opts.on('-d', '--date DATE', 'Sets the time range. Can be: 0 - overall, 7 - one week, 3/6/12 - monts.') do |d| 
		options[:date] = d || nil
	end

	opts.on('-c', '--counter COUNTER', 'Sets how many artists has tag cloud to display. Can\'t be less than 1 and more than 50.') do |c| 
		options[:count] = c || nil
	end
	
	opts.on('-o', '--output FILE', 'Sets the output file.') do |arg|
    		options[:output] = arg || nil
	end

	options[:random] = false
	opts.on('-r', '--random', 'Sets the output to be shuffled.') do
    		options[:random] = true
	end
end

	if ARGV.size < 1
		puts @usage
		exit
	else
		begin
			optparse.parse!
		rescue => e
			puts e
			puts "To see help, type:" 
			puts "$ ruby #{File.basename(__FILE__)} -h"
			exit
	end

end

puts
puts "cloudy v" + version.to_s + " by ian992."
puts "koscielniak.krystian@gmail.com"
puts
@cloud = TagCloud.new(options[:user], 
	options[:date].to_i, 
	options[:count].to_i, 
	options[:random], 
	options[:output])

puts "Fetching XML from remote server."
@cloud.fetch_xml
puts "Saving data to local file."
@cloud.save_to_file
puts "File saved - " + @cloud.output + ". Now copy the contents of the file and paste it into your profile at last.fm."
puts "Hell Yeah! \\m/"
