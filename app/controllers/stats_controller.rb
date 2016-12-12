class StatsController < ApplicationController
  def index
    # setup some basic statistical data
    @totalGuesses = Guess.count
    @correctGuesses = countCorrectGuesses

    @percentAccuracy = (((@correctGuesses.to_f / @totalGuesses.to_f).round(2)) * 100).round(0)

    # the data for the d3 graph will come from #data
  end

  def data
    respond_to do |format|
      guesses = Guess.select(:height, :weight, :actualvalue)

      format.json {
        render :json => guesses
        #   render :json => [1,2,3,4,5]
      }
    end
  end
end
