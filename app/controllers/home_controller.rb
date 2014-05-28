class HomeController < ApplicationController
  def index
        @key = "LKnK9JeMKEn5uRDHaZeNO4IUxkxiWOx8tNPeMcZl2IpfV8GLpU"
        @secret = "u0mHkS1p3QxXCTBmt5LnCGDMQc8ZuNZ5VjFTq5wA7EvgvhvyYC"
        @oauth_token = "UBvogCSj90wpvXXg53nYRWmGnFgbm1C08B8nXSuCvUa7uuID1c"
        @oauth_token_secret = "bBP8LdTg1fLhrMS8BoELWn560EQpkhKwMpZGXbfxY1fC0UuYi1"
        @myClient = Tumblr::Client.new(
            :consumer_key => @key,
            :consumer_secret => @secret,
            :oauth_token => @oauth_token,
            :oauth_token_secret => @oauth_token_secret
        )
        @posts = @myClient.posts("thehouseofsound.tumblr.com", :limit => 10)
        @posts = @posts["posts"]

    # @user = Tumblog.find_by_user_id(5)
    # @client = Tumblr::Client.new(:consumer_key => @key, :consumer_secret => @secret, :oauth_token => @user.oauth_token, :oauth_token_secret => @user.oauth_secret)
    # @client.text("{blogname}.tumblr.com", :body => "test", :state => "draft")
    # redirect_to "http://www.tumblr.com/blog/{blogname}/drafts"
  end
end
