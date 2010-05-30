require 'net/http'
require 'rubygems'
require 'xmlsimple'

class TagCloud
	attr_accessor :output
	def initialize (user, date=0, count=10, random=false, output=nil)
		@user = user
		@date = date
		@random = random

		# default values:
		if (count < 1 || count > 50)
			puts "Counter set to 10. Check help for more information."
			@count = 10
		end
		if (!output || output.empty?) 
			@output = @user + "_cloudy.txt"
		else
			@output = output
		end	
	end	

	# fetches remote xml
	def fetch_xml()	

		# checkes if given date is correct
		case @date
			when 7 then @url = 'http://ws.audioscrobbler.com/2.0/user/' + @user + '/weeklyartistchart.xml'
			when 0 then @url = 'http://ws.audioscrobbler.com/2.0/user/' + @user + '/topartists.xml'
			when 3 then @url = 'http://ws.audioscrobbler.com/2.0/user/' + @user + '/topartists.xml?period=' + @date.to_s + 'month'
			when 6 then @url = 'http://ws.audioscrobbler.com/2.0/user/' + @user + '/topartists.xml?period=' + @date.to_s + 'month'
			when 12 then @url = 'http://ws.audioscrobbler.com/2.0/user/' + @user + '/topartists.xml?period=' + @date.to_s + 'month'
		else 
			puts "Date set to overall. Check help for more information."
			@url = 'http://ws.audioscrobbler.com/2.0/user/' + @user + '/topartists.xml'
		end	

		# tries to fetch data from remote server
		begin	
			@xml_data = Net::HTTP.get_response(URI.parse(@url)).body
			@data = XmlSimple.xml_in(@xml_data)
		rescue
			puts "User not found. Are you sure that this user exists?"
			exit
		end

		# generates bbcode for output
		i = 0
		size = 18
		@output_data = ""

		@data['artist'].each do |item|
			item.sort.each do |k, v|
				if (i < @count)
					if ["name"].include? k
						@output_data << " [size=" + size.to_s + "]" if k=="name"
						@output_data << "[artist]" + v[0] if k=="name"
						@output_data << "[/artist][/size] \n" if k=="name"
						i += 1
						size -= 1 if (size > 1)
					end
				end
			end
		end
	end
	
	# shuffles an array
	def shuffle_array(a)
	    (a.size-1).downto(1) { |i|
	        j = rand(i+1)
	        a[i], a[j] = a[j], a[i] if i != j
	    }
	end

	# randomizes the output lines
	def randomize
		lines = Array.new
		@output_data.each do |line|
			lines << line.chomp
		end
		shuffle_array(lines)
		@output_data = lines.to_s
	end

	# saves data to file
	def save_to_file
		File.open(@output, "w+") do |file|
			file.puts "[b][align=center]"
			randomize if @random
			@output_data.each_line { |line| line.delete('\n') }
			file.puts @output_data
			file.puts "[/align][/b][align=center][sup]Made with [user]ian992[/user]'s [url=http://github.com/kryszan/cloudy]cloudy[/url]\\m/ [/sup][/align]"
		end
	end
end

