# petguess
#
*PetGuess*

A single-page web app that guesses the user's pet preference based on their height and weight.
Also provides a scatter plot of all past data collected.

Implemented using JavaScript/jQuery on the front-end and Ruby/Rails on the backend.

Improvements to be made:
 - I didn't realize there were ActiveRecord enums until later on -- this would definitely be a helpful refactoring.
 - The scatter plot could be a little nicer and more polished (I was having trouble getting the axis labels, for example)
 - The backend should be generating UUIDs and sending those back to the client instead of its internal database IDs (security)
 - The scatter plot caused me to realize that you could easily end up with rows in the database without an "actualvalue" (correct value)
    because of the current interaction pattern between the frontend and backend (requesting the "guess" causes the new row
    to be committed). In retrospect, it would be better to expose an endpoint that just generates the guess value without
    committing the row, and only once the user indicated the "correct value" would the client request that the backend
    persist the entry. This might also obviate the need for the UUIDs as well, since the client wouldn't need to know
    about the created entity on the backend.
 - The guess algorithm is pretty primitive and assumes something like a linear relationship. Depending on the shape of the data
   we would need to use different kinds of statistical techniques (other types of regression analysis, perhaps)
 - I'm not fully happy with how I used a different controller for the Statistics display. This could probably be refactored.
 - I didn't have time to write front-end tests, or sufficiently exhaustive back-end tests. These will have to be added.