class Movie < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  belongs_to :director
  belongs_to :genre
end
