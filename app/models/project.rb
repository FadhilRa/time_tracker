class Project < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :tasks, presence: true

  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank
end
