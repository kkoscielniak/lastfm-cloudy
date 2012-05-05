lastfm-cloudy
======
**Date:** 21.02.2010  
  
**What?**  
With cloudy you can easily create cloud of your favourite artists on your last.fm profile. cloudy generates BB-Code, which you can paste in your profile's about box.

**Requirements?**  
You'll need Ruby 1.8 and *xml-simple* gem. If you have RubyGems just type in terminal:  
	$ gem install xml-simple  
	  
**How to use?**  
To generate BB-Code you have to get to script's directory and run this command in your shell:  
	$ ruby cloudy.rb [user] [options]  
where `[user]` is your username. Options are optional, i'll explain them later. For example:  
	$ ruby cloudy.rb ian992  
will generate cloud from ian992's data, and save it's code as *ian992_cloudy.txt*. You can specify an output filename by using `-o` option. For example:  
	$ ruby cloudy.rb ian992 -o output.txt  
will generate cloud and save it's code as *output.txt*. If you want to specify how many artists has cloudy to save in file you should use `-c` option. For e.g:  
	$ ruby cloudy.rb ian992 -c 5  
will generate code containg only 5 artists. The counter can't be less than 1 and more than 50. You can also select time range that cloudy should use. It can be: 0 for overall statistics, 7 for one week, 3/6/12 for months. Default value is 0. To specify this you have to use `-d` option. E.g:  
	$ ruby cloudy.rb ian992 -c 5 -d 7  
will generate code of cloud containing most played artists from last week. The last option is `-r`. This will mix the items in the cloud:  
	$ ruby cloudy.rb ian992 -c 5 -d 7 -r  

It's **simple**, isn't it?  

**Why I made it?** In case of Ruby learning. I just began to learn this.   
**Copyright?** No, copyleft. Definitely.  
**Something else?** See you at my last.fm [profile](http://last.fm/user/kryszanek)!
