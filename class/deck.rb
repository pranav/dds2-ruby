
class Deck < ActiveRecord::Base
  has_one :name
  has_one :uuid
  has_one :uid
  has_and_belongs_to_many :machine

end

class DeckMigration < ActiveRecord::Migration
  def up
    create_table :deck do |t|
      t.string :name
      t.string :uuid
      t.integer :uid
    end
  end

  def down
    drop_table :deck
  end
end
