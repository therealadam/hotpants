class Hotpants::Index

  attr_accessor :prefix, :connection

  def initialize(prefix, connection)
    self.prefix, self.connection = prefix, connection
  end

  def []=(key, value)
    connection.set(key, value)
  end

  def [](key)
    connection.get(key)
  end

end
