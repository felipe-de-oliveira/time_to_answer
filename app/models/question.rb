class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers
  accept_nested_attributes_for :answers
end
