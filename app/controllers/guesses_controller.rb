class GuessesController < ApplicationController
  def index
    # setup some basic statistical data that will be displayed in the header
    @totalGuesses = Guess.count
    @correctGuesses = countCorrectGuesses

    print("total guesses: " + @totalGuesses.to_s)
    print("correct guesses: " + @correctGuesses.to_s)

    # forced coercions to float are necessary to prevent integer math...
    # TODO check for divide by zero
    @percentAccuracy = (((@correctGuesses.to_f / @totalGuesses.to_f).round(2)) * 100).round(0)
  end

  # Called by the frontend to both "guess" the value and create the row in the database for this user
  def create
    # get the input parameters (height and weight) from the client request
    if (!params['height'] || !params['weight']) then
      render json: {error: 'error: missing parameter', status: 400}.to_json
    end
    height = params['height'].to_i
    weight = params['weight'].to_i

    # Use the simple distance algorithm to determine the guess
    guessedValue = guessPreferredAnimal(height, weight)

    # Store the user's input and the guessed value; we'll later update the record with the "actual" value
    guess = Guess.create(height: height, weight: weight, guessvalue: guessedValue)
    guess.save!

    # Return the now-persisted information, including the guess, to the browser as JSON
    # TODO: error handling could be better in this method
    render json: guess
  end

  # Called by the frontend to update the guess with the "actual value" (e.g., the user's actual preference of animal)
  def update
    # get the input parameters (id and actualvalue) from the client request
    id = params['id'].to_i
    actualvalue = params['actualvalue']

    guess = Guess.find(id)
    guess.actualvalue = actualvalue
    guess.save!

    # TODO: error handling could be better in this method
    render json: guess
  end

  # Attempts to "guess" the user's preference given height and weight
  #
  # Implementation attempts to see whether the user values are closer to
  # the averages for those who like dogs or cats, respectively. This is something
  # like a very simple linear regression. This would require updates if the relationships
  # turned out to be nonlinear.
  def guessPreferredAnimal(height, weight)
    # Calculate the average height and weight for those who liked dogs/cats
    dogAvgHeight = Guess.where(actualvalue: 'dog').average("height").to_d
    dogAvgWeight = Guess.where(actualvalue: 'dog').average("weight").to_d
    catAvgHeight = Guess.where(actualvalue: 'cat').average("height").to_d
    catAvgWeight = Guess.where(actualvalue: 'cat').average("weight").to_d

    # Get the distance from the average and divide by the entered value (so we can sum the fractional parts)
    distFromDogAvgHeight = (dogAvgHeight - height).abs / height
    distFromDogAvgWeight = (dogAvgWeight - weight).abs / weight
    distFromCatAvgHeight = (catAvgHeight - height).abs / height
    distFromCatAvgWeight = (catAvgWeight - weight).abs / weight

    # Add the fractional distances; the smaller value is the guess
    totalDog = distFromDogAvgWeight + distFromDogAvgHeight
    totalCat = distFromCatAvgWeight + distFromCatAvgHeight

    if totalCat > totalDog then
      guessValue = 'dog'
    else
      guessValue = 'cat'
    end

    guessValue
  end

  # Query to count the number of correct guesses across all entries in the Guesses table
  def countCorrectGuesses
    query = <<-SQL
  SELECT COUNT(*) 
  FROM guesses
  WHERE actualvalue LIKE guessvalue
    SQL

    ActiveRecord::Base.connection.execute(query)[0]['COUNT(ID)']
  end
end