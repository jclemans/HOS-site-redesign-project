class HomeController < ApplicationController
  def index
    @schedules = Schedule.where(day_of_week: Date.today.wday)
        # @key = "LKnK9JeMKEn5uRDHaZeNO4IUxkxiWOx8tNPeMcZl2IpfV8GLpU"
        # @secret = "u0mHkS1p3QxXCTBmt5LnCGDMQc8ZuNZ5VjFTq5wA7EvgvhvyYC"
        # @oauth_token = "UBvogCSj90wpvXXg53nYRWmGnFgbm1C08B8nXSuCvUa7uuID1c"
        # @oauth_token_secret = "bBP8LdTg1fLhrMS8BoELWn560EQpkhKwMpZGXbfxY1fC0UuYi1"
        # @myClient = Tumblr::Client.new(
        #     :consumer_key => @key,
        #     :consumer_secret => @secret,
        #     :oauth_token => @oauth_token,
        #     :oauth_token_secret => @oauth_token_secret
        # )
        # @posts = @myClient.posts("thehouseofsound.tumblr.com", :limit => 10)
        # @posts = @posts["posts"]

  def listen_live
    render layout: 'bare'
  end

  def index
  end
end
