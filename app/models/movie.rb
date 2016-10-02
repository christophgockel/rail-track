class Movie < ActiveRecord::Base
  validates :title, presence: true
  validate  :release_date_is_after_1895

  private

  def release_date_is_after_1895
    if release_date.nil?
      errors.add(:release_date, "must be be provided.")
    elsif release_date.year < 1895
      errors.add(:release_date, "is older than the world's first motion picture.")
    end
  end
end
