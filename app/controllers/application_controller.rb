class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # Query to count the number of correct guesses across all entries in the Guesses table
  #
  # Here because it's used by two different controllers.
  def countCorrectGuesses
    query = <<-SQL
  SELECT COUNT(ID) 
  FROM guesses
  WHERE actualvalue = guessvalue
    SQL

    ActiveRecord::Base.connection.execute(query)[0]['COUNT(ID)']
  end
end
