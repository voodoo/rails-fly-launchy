class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :user, to: :session, allow_nil: true
  delegate :root_user, to: :class

  def self.root_user
    User.order(:created_at).first
  end
end
