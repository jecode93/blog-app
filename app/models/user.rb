class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def three_most_recent_posts
    Post.where(author_id: self).order(created_at: :desc).limit(3)
  end

  # Add validations

  # Name must not be blank.
  validates :name, presence: true

  # PostsCounter must be an integer greater than or equal to zero.
  validates :posts_counter, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }
end

# <%= render 'posts/all_posts' %>
