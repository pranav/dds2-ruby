$LOAD_PATH << "."
require 'active_record'
require 'config.rb'
require 'class/deck.rb'

DeckMigration.new.up
