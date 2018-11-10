class Comment < ApplicationRecord
  belongs_to :parent,  class_name: "Comment", optional: true, foreign_key: 'parent_id'
  has_many   :replies, class_name: "Comment", dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 2 }
  def nest_level
    nest_level = 1
    comment = self
    while comment.comment_id do
      comment = Comment.find(comment.comment_id)
      nest_level = nest_level + 1
    end
    return nest_level
  end
end
