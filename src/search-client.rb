require 'mechanize'

class SearchClientResponse 
  attr_accessor :url

  def initialize(url) 
    @url = url
  end

end

class SearchClient
  attr_reader :links

  def initialize(params) 
    mechanize = Mechanize.new
    page = mechanize.get("http://google.com/search?q='#{params.join(' ')}'")
    links = page.links_with(href: /^\/url/)

    raise SearchClientError, "No Results" if links.length === 0

    readable_links = links.collect do |link| 
      url = link.href[/.*\?q=(.*)/, 1].split('&')[0] 
      SearchClientResponse.new(url)
    end

    @links = readable_links || []
  end

  def to_html
    html = @links.collect do |link|
      "<a href='#{link.url}'>#{link.url}</a>"    
    end
    html.join('')
  end
end

class SearchClientError < StandardError; end
