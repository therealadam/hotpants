require "hotpants"

RSpec.configure do |c|
  
  def memcached
    Memcached.new("localhost:11211")
  end

end
