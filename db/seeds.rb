# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do

  users = User.create([{name: "Homer"}, {name: "Marge"}, {name: "Bart"}])

  fav_beer = Poll.create({title: "Favourite beer", author_id: 1})
  fav_food = Poll.create({title: "Favourite foods", author_id: 2})
  fav_sport = Poll.create({title: "Favourite sports", author_id: 3})

  fav_beer_q1 = Question.create({text: "Favourite light beer?", poll_id: 1})
  fav_beer_q2 = Question.create({text: "Favourite dark beer?", poll_id: 1})

  fav_food_q1 = Question.create({text: "Favourite breakfast food?", poll_id: 2})
  fav_food_q2 = Question.create({text: "Favourite dessert?", poll_id: 2})

  fav_sport_q1 = Question.create({text: "Favourite American sport?", poll_id: 3})
  fav_sport_q2 = Question.create({text: "Favourite proper sport?", poll_id: 3})

  fav_beer_q1_a1 = AnswerChoice.create({text: "Bud Light", question_id: 1})
  fav_beer_q1_a2 = AnswerChoice.create({text: "Carlsberg Light", question_id: 1})
  fav_beer_q2_a1 = AnswerChoice.create({text: "Bud", question_id: 2})
  fav_beer_q2_a2 = AnswerChoice.create({text: "Carlsberg", question_id: 2})

  fav_food_q1_a1 = AnswerChoice.create({text: "Bacon", question_id: 3})
  fav_food_q1_a2 = AnswerChoice.create({text: "Eggs", question_id: 3})
  fav_food_q2_a1 = AnswerChoice.create({text: "Cake", question_id: 4})
  fav_food_q2_a2 = AnswerChoice.create({text: "Triffle", question_id:4})

  fav_sport_q1_a1 = AnswerChoice.create({text: "Baseball", question_id: 5})
  fav_sport_q1_a2 = AnswerChoice.create({text: "American football", question_id: 5})
  fav_sport_q2_a1 = AnswerChoice.create({text: "Football", question_id: 6})
  fav_sport_q2_a2 = AnswerChoice.create({text: "Cricket", question_id:6})

  response_Bart_food_q1 = Response.create({respondent_id: 3, answer_choice_id: 5})
  response_Bart_food_q2 = Response.create({respondent_id: 3, answer_choice_id: 8})

  response_Homer_sport_q1 = Response.create({respondent_id: 1, answer_choice_id: 9})
  response_Homer_sport_q2 = Response.create({respondent_id: 1, answer_choice_id: 11})

  response_Marge_sport_q2 = Response.create({respondent_id: 2, answer_choice_id: 11})

end