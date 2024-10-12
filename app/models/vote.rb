class Vote < ApplicationRecord
  belongs_to :story, counter_cache: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: :story_id, message: "You can only vote once per story" }
end
