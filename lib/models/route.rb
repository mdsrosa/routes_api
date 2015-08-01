class Route < ActiveRecord::Base
  validates_presence_of :origin_point, :destination_point, :distance
  validates_uniqueness_of :origin_point, :scope => :destination_point
  validates_numericality_of :distance, :only_integer => true, :allow_nil => true
end