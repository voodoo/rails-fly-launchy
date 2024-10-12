class Story < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  validates_format_of :url, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i

end
