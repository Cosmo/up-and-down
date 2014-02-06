# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
question1 = Question.create(text: "Leonard DiCaprio")
question2 = Question.create(text: "Most Popular")
question3 = Question.create(text: "Biography")
question4 = Question.create(text: "Martin Scorsese")
question5 = Question.create(text: "Kate Winslet")
question6 = Question.create(text: "Romance")
question7 = Question.create(text: "90s")
question8 = Question.create(text: "Academy Awards nominee")
question9 = Question.create(text: "Comedy")
question10 = Question.create(text: "Recent Release")

movie = Movie.create(name: "The Wolf of Wall Street", poster_url: "http://ia.media-imdb.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_SX640_SY720_.jpg")
movie.questions << question1
movie.questions << question2
movie.questions << question3
movie.questions << question4
movie.questions << question8
movie.questions << question9
movie.questions << question10

movie = Movie.create(name: "Titanic", poster_url: "http://media.tumblr.com/tumblr_mejqzszPbZ1rxcj5p.jpg")
movie.questions << question1
movie.questions << question5
movie.questions << question6
movie.questions << question7
movie.questions << question8