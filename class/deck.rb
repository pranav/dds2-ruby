
class Deck < ActiveRecord::Base
  has_one :name
  has_one :uuid
  has_one :uid
  has_and_belongs_to_many :machine

end
