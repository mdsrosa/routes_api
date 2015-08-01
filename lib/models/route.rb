class Route < ActiveRecord::Base
  validates_presence_of :origin_point, :destination_point, :distance
  validates_uniqueness_of :origin_point, :scope => :destination_point
  validates_numericality_of :distance, :only_integer => true, :allow_nil => true

  def self.points
    points = Route.select(:origin_point, :destination_point)
    origin_points = points.map(&:origin_point)
    destination_points = points.map(&:destination_point)
    (origin_points + destination_points).uniq
  end
end