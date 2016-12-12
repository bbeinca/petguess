class StatsController < ApplicationController
  def index
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
