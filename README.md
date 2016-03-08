# runHacker
## Custom analytics to help you improve your running performance

Author: Toni Rib

Live Version: [http://run-hacker.herokuapp.com/](http://run-hacker.herokuapp.com/)

### Overview

This Ruby on Rails application was designed to give runners insights into any trends that might exist in their running habits. After logging in through MapMyFitness, all of a user's runs are imported along with information on location, elevation, and temperature at the time of the run.

Users can then create charts plotting distance, average speed, and/or time spent resting against temperature, elevation, location, season, and time of day. They can also view a listing of all their runs and have the ability to click on an individual run to see a map of the route and information specific to that run. The user's dashboard has aggregate information for all of their runs, such as the total distance they have run since joining MapMyFitness. The dashboard updates automatically as new runs are loaded every time the user signs into the app.

The application is [hosted live on Heroku](http://run-hacker.herokuapp.com/) and uses background workers (redis/sidekiq) to make the API calls that import the user's data.

### Application In Action

Eventually put recording here

### Dependencies

To run this application locally, you would need to obtain API keys from the following sources:

* [MapMyFitness](https://developer.underarmour.com/)
* [Google Geocoder](https://developers.google.com/maps/documentation/geocoding/introgoo)
* [Google Elevation](https://developers.google.com/maps/documentation/elevation/intro)
* [Google Time Zone](https://developers.google.com/maps/documentation/timezone/intro)
* [Google Maps](https://developers.google.com/maps/documentation/javascript/)
* [Weathersource](https://developer.weathersource.com/documentation/)

Gem dependencies can be found in the Gemfile.

### Additional Information

Because this was a project for the [Turing School of Software and Design](http://turing.io) and I did not want to pay for historical weather data, the application can only make 10 requests per minute to the weather API. Thus, if you are importing a large number of workouts all at the same time, it will take multiple minutes for the temperatures to get updated. However, the application will simply show "Not Available" for the temperature of any workouts until that point and those data points will not be available for plotting on the temperature chart.
