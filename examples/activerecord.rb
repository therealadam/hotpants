require "bundler"
Bundler.setup#(:examples)

require "active_record"
require "ffaker"
require "hotpants"

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :username, :null => false
    t.integer :age, :null => false
    t.integer :gizmo
  end
end

class User < ActiveRecord::Base
  include Hotpants

  value :histogram
end

$memcached = Memcached.new("localhost:11211") # HAX

u = User.create(:username => "akk", :age => 31, :gizmo => 42)
u.histogram = {"pizza" => 34, "hamburger" => 22, "taco" => 11, "orange" => 1}

p User.where(:username => "akk").first.histogram

