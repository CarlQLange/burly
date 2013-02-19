$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'uri'
require 'colored'

module Burly
  VERSION = '0.0.1'

  class Burly
	def initialize (text, opts = {})
		@text = text
		@urls = get_urls(text)
		@opts = {
			:display_context => false,
			:display_colours => false
		}.merge(opts)
	end

	def get_urls (text)
		URI.extract(text) #this doesn't catch "google.com", but most everything else
	end

	def get_context (url, text)
		url
	end

	def display_urls
		stuff_to_display = []

		if @opts[:display_context]
			stuff_to_display = @urls.map {|url| 
				url_with_context = get_context(url, @text)
				url_with_context.gsub! url, url.bold.blue if @opts[:display_colours]
			}
		else
			@urls.each_with_index {|url, i| 
				url = url.bold.blue if @opts[:display_colours]
				stuff_to_display.push "#{i+1}. #{url}"
			}
		end

		puts stuff_to_display
	end
  end
end
