class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :comment, presence: true

  def days_passed
    year = created_at.year
    month = created_at.month
    day = created_at.mday
    created_date = Date.new(year, month, day)
    if Date.today - created_date == 0
      "本日"
    else
      date = Date.today - created_date
      "#{date.to_i}日前"
    end
  end
end