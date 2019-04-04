require 'httpclient'

class NicoSnapshotApi
  def initialize
    @version = "v2"
    @endpoint = 'https://api.search.nicovideo.jp/api/v2/snapshot/video/contents/search'
    @user_agent = "nico-api"
    @client = HTTPClient.new
    @client.debug_dev = $stderr
  end

  def search_keyword(keyword)
    query = { 
      'q' => keyword,
      'targets' => 'title,description,tags',
      'fields' => 'contentId,title,viewCounter,mylistCounter,commentCounter,startTime,lengthSeconds', # option
      '_sort' => 'startTime',
      '_context' => 'nico-api'
    }
    http_get(merge_default(query))
  end

  private
  def merge_default(query={})
    default_query = {
      'targets' => 'title,description,tags',
      '_sort' => '+startTime',
      '_context' => 'nico-api'
    }
    default_query.merge(query)
  end

  def http_get(query)
    res = @client.get(@endpoint, query: query, :follow_redirect => true, default_header: {"User-Agent" => @user_agent})
    #puts "code=#{res.code}"    # res.code : Fixnum
    #puts HTTP::Status.successful?(res.code)
    #p res.headers
    res.body
  end
end

api = NicoSnapshotApi.new
puts api.search_keyword("ゲーム")
