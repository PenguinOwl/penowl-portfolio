class Comment < ApplicationRecord
  belongs_to :comment_thread
  belongs_to :parent,  class_name: "Comment", optional: true, foreign_key: 'parent_id'
  has_many   :replies, class_name: "Comment", dependent: :destroy
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
