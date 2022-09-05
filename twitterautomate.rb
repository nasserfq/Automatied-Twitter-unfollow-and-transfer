#By: Nasser Alqahtani
#Twitter: thenasser93

require 'rubygems'
require 'bundler/setup'
require 'twitter'
require 'json'
require 'yaml'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

# use the access token as an agent to get the home timeline
response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")
following_list = client.friends("TwitterAccountExample")
created_list = client.create_list("ThursdayList1")

friendsArray = []

begin

  for friend in following_list
    friendsArray.push(friend.screen_name)
  end



  #Loop through authenticated user friends list and add them to created_list
  friendsArray.each do |user_names|

    client.add_list_member("TwitterAccountExample","ThursdayList1",user_names)

  end


  #Loop through authenticated user friends list and unfollow them
  friendsArray.each do |unfollowed_users|

    client.unfollow(unfollowed_users)

  end


rescue Twitter::Error::TooManyRequests => error
  # NOTE: Your process could go to sleep for up to 15 minutes but if you
  # retry any sooner, it will almost certainly fail with the same exception.
  sleep error.rate_limit.reset_in + 1
  retry
end
