class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews #reviewを複数持っている

  def reviews_new
    reviews.new
  end
end
