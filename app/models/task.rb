class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: { message: "name is required" }
  validates :name, length: { minimum: 3 }

  validates :importance, inclusion: { in: %w(high middle low),
                                      message: "%{value} is not a valid size" }

  enum :importance => [:high, :middle, :low]
end
