# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Guess.delete_all

Guess.create!([
                  {id: 1, height: 50, weight: 100, guessvalue: 'cat', actualvalue: 'cat'},
                  {id: 2, height: 55, weight: 110, guessvalue: 'cat', actualvalue: 'cat'},
                  {id: 3, height: 60, weight: 120, guessvalue: 'cat', actualvalue: 'cat'},
                  {id: 4, height: 65, weight: 130, guessvalue: 'dog', actualvalue: 'dog'},
                  {id: 5, height: 70, weight: 140, guessvalue: 'cat', actualvalue: 'dog'},
              ])
