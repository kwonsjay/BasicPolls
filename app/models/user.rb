class User < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => true

  has_many(
  :authored_polls,
  :class_name => "Poll",
  :foreign_key => :author_id,
  :primary_key => :id
  )

  has_many(
  :responses,
  :class_name => "Response",
  :foreign_key => :respondent_id,
  :primary_key => :id
  )

  has_many :answer_choices, :through => :responses, :source => :answer_choice


  # def completed_polls
  #   questions_answered = self.answer_choices.map { |choice| choice.question_id }
  #   polls_completed = []
  #   polls = Poll.includes(:questions)
  #   polls.each do |poll|
  #     complete = true
  #     poll_questions = poll.questions
  #     poll_questions.each do |question|
  #       if !questions_answered.include?(question.id)
  #         complete = false
  #         break
  #       end
  #     end
  #     polls_completed << poll if complete
  #   end
  #   polls_completed
  # end

  def completed_polls
    questions_answered = self.answer_choices.map { |choice| choice.question_id }
    polls_completed = []
    polls_started = []
    polls = Poll.includes(:questions)
    polls.each do |poll|
      complete = true
      started = false
      poll_questions = poll.questions
      poll_questions.each do |question|
        if questions_answered.include?(question.id)
          started = true
        else
          complete = false
        end
      end
      polls_completed << poll if complete
      polls_started << poll if started
    end
    [polls_completed, polls_started]
  end

  def uncompleted_polls
    polls_completed, polls_started = completed_polls
    polls_started - polls_completed
  end

end
