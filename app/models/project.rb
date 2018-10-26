class Project < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 30 }
  validates :imagelink, presence: true, length: { minimum: 5 }
end
