class Story < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :url, presence: true
  validates_format_of :url, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i
  after_commit :vote_for_new_story, on: :create   

  def vote_for_new_story
    self.votes.create(user: Current.user)
  end
end
