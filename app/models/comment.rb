class Comment < ApplicationRecord
  belongs_to :billboard
  validates :body, presence: true

end
