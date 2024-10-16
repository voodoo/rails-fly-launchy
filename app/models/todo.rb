class Todo < ApplicationRecord
  belongs_to :user
  broadcasts_to ->(todo) { "todos" }, inserts_by: :prepend

end
