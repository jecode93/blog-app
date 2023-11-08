class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  after_save :update_post_counter

  def five_recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def all_comments
    Comment.where(post_id: id)
  end

  # Add validations

  # Title must not be blank.
  validates :title, presence: true

  # Title must not exceed 250 characters.
  validates :title, length: { maximum: 250 }

  # CommentsCounter must be an integer greater than or equal to zero.
  validates :comments_counter, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }

  # LikesCounter must be an integer greater than or equal to zero.
  validates :likes_counter, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }
end
