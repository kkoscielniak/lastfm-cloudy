require File.expand_path(File.dirname(__FILE__) + "/lib/cloudy.rb")
require "optparse"

options = {}

optparse = OptionParser.new do |opts|
	opts.banner = "Usage: cloudy [user] [options]"	
	@usage = opts
    opts.on('-h', '--help', 'Displays this screen.') do
    	puts opts
    	exit
    end

    options[:user] = ARGV.first

	opts.on('-d', '--date DATE', 'Sets the time range. Can be: 0 - overall, 7 - one week, 3/6/12 - months.') do |d| 
		options[:date] = d
	end

	opts.on('-c', '--count COUNT', 'Sets how many artists has tag cloud to display.') do |c| 
		options[:count] = c
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
			puts "$ #{File.basename(__FILE__)} -h"
			exit
	end

end

@cloud = TagCloud.new(options[:user],options[:date].to_i,options[:count].to_i,options[:random], options[:output])

puts "Fetching XML from remote server."
@cloud.fetch_xml
puts "Saving to local file."
@cloud.save_to_file
puts "File saved - " + @cloud.output + ". Now copy the contents of the file and paste it into your profile at last.fm."
puts "Hell Yeah ! \\m/"
