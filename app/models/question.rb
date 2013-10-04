class Question < ActiveRecord::Base
  attr_accessible :text, :poll_id

  validates :text, :presence => true

  belongs_to(
  :poll,
  :class_name => "Poll",
  :foreign_key => :poll_id,
  :primary_key => :id
  )

  has_many(
  :answer_choices,
  :class_name => "AnswerChoice",
  :foreign_key => :question_id,
  :primary_key => :id,
  :dependent => :destroy
  )

  def results
    answers = self.answer_choices.includes(:responses)
    count_hash = {}
    answers.each do |answer|
      count_hash[answer.text] = answer.responses.count
    end
    count_hash
  end



end
