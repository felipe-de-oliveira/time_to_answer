class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions 
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  paginates_per 5

  def self.search_subject(subject_id)
    @questions = Question.includes(:answers).order('created_at desc')
                         .where(subject_id: subject_id)
  end 
  def self.search(term)
    @questions = Question.includes(:answers).order('created_at desc')
                         .where("lower(description) LIKE ? ",  "%#{term.downcase}%")
  end 
end  