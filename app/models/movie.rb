class Movie < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :released_on, presence: true

  def self.released
    Movie.where("released_on < ?", Time.now).order(released_on: :desc)
  end

  def self.hits
    Movie.where("total_gross >= ?", 300_000_000).order(total_gross: :desc)
  end

  def self.flops
    Movie.where("total_gross < ?", 225_000_000).order(total_gross: :asc)
  end

  def self.recently_added
    order(created_at: :desc).limit(3)
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end
end
