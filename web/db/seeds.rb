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

movie = Movie.create(name: "Revolutionary Road", poster_url: "http://upload.wikimedia.org/wikipedia/en/2/28/Revolutionary_road.jpg")
movie.questions << question1
movie.questions << question5
movie.questions << question6
movie.questions << question8

movie = Movie.create(name: "Malavita - The Family", poster_url: "http://upload.wikimedia.org/wikipedia/en/7/75/The_Family_2013%2C_Poster.jpg")
movie.questions << question4
movie.questions << question10
movie.questions << question9

movie = Movie.create(name: "Shutter Island", poster_url: "http://upload.wikimedia.org/wikipedia/en/7/76/Shutterislandposter.jpg")
movie.questions << question1
movie.questions << question4

movie = Movie.create(name: "The Holiday", poster_url: "http://upload.wikimedia.org/wikipedia/en/6/60/Theholidayposter.jpg")
movie.questions << question5
movie.questions << question6
movie.questions << question8
movie.questions << question9

movie = Movie.create(name: "All the King's Men", poster_url: "http://upload.wikimedia.org/wikipedia/en/d/df/All_the_kings_men.jpg")
movie.questions << question5
movie.questions << question6
movie.questions << question2

movie = Movie.create(name: "Little Children", poster_url: "http://upload.wikimedia.org/wikipedia/en/8/81/Little_children_post.jpg")
movie.questions << question5
movie.questions << question8
movie.questions << question6

movie = Movie.create(name: "Naked in New York", poster_url: "http://upload.wikimedia.org/wikipedia/en/f/fa/Nakedinnewyork.jpg")
movie.questions << question4
movie.questions << question7
movie.questions << question9

movie = Movie.create(name: "Hugo Cabret", poster_url: "http://upload.wikimedia.org/wikipedia/en/7/73/Hugo_Poster.jpg")
movie.questions << question4
movie.questions << question8
movie.questions << question9


