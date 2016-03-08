# runHacker
## Custom analytics to help you improve your running performance

Author: Toni Rib

### Overview

This Ruby on Rails application was designed to give runners insights into any trends that might exist in their running habits. After logging in through MapMyFitness, all of a user's runs are imported along with information on location, elevation, and temperature at the time of the run.

Users can then create charts plotting distance, average speed, and/or time spent resting against temperature, elevation, location, season, and time of day. They can also view a listing of all their runs and have the ability to click on an individual run to see a map of the route and information specific to that run. The user's dashboard has aggregate information for all of their runs, such as the total distance they have run since joining MapMyFitness. The dashboard updates automatically as new runs are loaded every time the user signs into the app.

The application is [hosted live on Heroku](http://run-hacker.herokuapp.com/) and uses background workers (redis/sidekiq) to make the API calls that import the user's data.
