require 'mysql'
require 'config.rb'

$mysql = Mysql.new $database_conf[:location], $database_conf[:username], $database_conf[:password], $database_conf[:name]

class Slide
  attr_accessor :id, :name, :uuid, :user, :group, :machines

  def initialize(
  def find_by_id(id)
    rs = $mysql.query("SELECT * FROM deck where id = '#{id}'")
    row = rs.fetch_row
    Slide.new
  end


end

