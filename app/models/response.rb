class Response < ActiveRecord::Base
  attr_accessible :answer_choice_id, :respondent_id

  validates_presence_of :answer_choice_id, :respondent_id
  validate :respondent_has_not_already_answered_question, :respondent_cannot_answer_own_poll

  belongs_to(
  :answer_choice,
  :class_name => "AnswerChoice",
  :foreign_key => :answer_choice_id,
  :primary_key => :id
  )

  belongs_to(
  :respondent,
  :class_name => "User",
  :foreign_key => :respondent_id,
  :primary_key => :id
  )

  def respondent_has_not_already_answered_question
    response_array = existing_responses
    if response_array.length == 0
      return true
    elsif response_array.length == 1 && response_array[0].id == self.id
      return true
    else
      errors[:response] << "You've already answered that question"
      return false
    end
  end

  def respondent_cannot_answer_own_poll
    owns = owns_poll
    respondents_own_answers = owns.map { |relation| relation.id }
    if respondents_own_answers.include?(self.answer_choice_id)
       errors[:response] << "You can't answer your own question!"
       return false
     else
       return true
     end

  end


  private
  def owns_poll
    AnswerChoice.find_by_sql ["

    SELECT
      answer_choices.id
    FROM
        users JOIN polls ON users.id = author_id
              JOIN questions ON polls.id = poll_id
              JOIN answer_choices ON questions.id = question_id
    WHERE author_id = ?

    ", respondent_id]
  end

  def existing_responses
    Response.find_by_sql ["

    SELECT
      responses.id
    FROM
        responses JOIN answer_choices
    ON
        answer_choice_id = answer_choices.id
    WHERE
      respondent_id = ?
    AND
      question_id IN (SELECT question_id
      FROM
        answer_choices JOIN responses
      ON
        answer_choices.id = ?
      )

    ", respondent_id, answer_choice_id]
  end


end
