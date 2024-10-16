class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :state, presence: true

  enum :state, {:pending=>0, :in_progress=>1, :completed=>2}

  scope :active, -> { where.not(state: :completed) }
  scope :complete, -> { where(state: :completed) }
  
  scope :due_soon, -> { where('due_date <= ?', 3.days.from_now) }

  def collapse
    update(state: :collapsed)
  end

  def uncollapse
    update(state: :pending)
  end
end