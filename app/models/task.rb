class Task < ApplicationRecord
  belongs_to :user
  validates :importance, inclusion: { in: %w(high middle low),
                                      message: "%{value} is not a valid size" }

  enum :importance => [:high, :middle, :low]
end
