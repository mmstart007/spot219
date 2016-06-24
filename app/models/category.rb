# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  
  has_many :place_categories

  has_many :places, through: :place_categories

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }

  validates_uniqueness_of :name

end
