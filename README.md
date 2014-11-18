##Springbot Lunch App

[![Code Climate](https://codeclimate.com/github/taylormartin/Lunchbot/badges/gpa.svg)](https://codeclimate.com/github/taylormartin/Lunchbot)
[![Build Status](https://travis-ci.org/taylormartin/Lunchbot.svg?branch=master)](https://travis-ci.org/taylormartin/Lunchbot)

This app is live at [springbotlunch.herokuapp.com](https://springbotlunch.herokuapp.com)

The app uses PostgreSQL for its database, so make sure you have this installed on your machine before trying to run this
app locally.

###Note About Changing Lunchspots Each Day

There is an option on the menu bar called "Update-Lunch-Spot". This is what will change the lunch spot each day. Ideally, if I were going to really use this app, I
would create a side job using something like Sidekiq, Sidetiq, and Redis to run this "Update-Lunch-Spot" action every night, so that when users went into the 
application each day to see what's for lunch the place would be updated and they wouldn't have to click anything. Since you guys said to focus more on the algorithm that is picking the spots, it didn't
seem practical to use time to create this nightly job. Also, it takes two dynos on Heroku to do that and Heroku charges for multiple dynos.

So...instead I have put this "Update-Lunch-Spot" button on the menu bar to simulate the action of updating the lunch spot day to day. If you would like a new spot
to be picked, just click on it.

###Explanation of the Algorithm

 I tried to write the algorithm in such a way that it would be easily updated in the future if adjustments needed to be made. That is, say you actually want to expand
 the number of days back the algorithm reaches for a restaurant or you want to raise the rating category it looks for first, this should be very easy based on the way I have structured it.

 I also tried to think about what will keep users happy in terms of lunch spots. Assuming the users go to the lunch spot the app picks each day, then mark it visited, then rate the restaurant, the app will send them to restaurants they like pretty much all the time. Say there are five restaurants in the database that are 4 rated and then a whole bunch of restaurants that are 1 and 2 rated, is there really any reason to send users to the ones they don't like when they already have a weeks worth of restaurants they do like.

 Say however, that users decide that five restaurants week after week is just not enough variety. It's easy to adjust the algorithm to pick 3 rated places that were visited longer ago than the 4 rated places that were just visited last week.

 I think you probably get the idea, and besides, you'll see what I'm talking about when you look at the alogrithm. It's in the restaurant model, by the way.

 Thanks for taking a look, and let me know if you have any questions about anything.