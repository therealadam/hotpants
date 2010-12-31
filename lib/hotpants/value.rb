class Hotpants::Value

  attr_accessor :key, :connection, :block

  def initialize(key, connection)
    self.key, self.connection = key, connection
  end

  # Borrowed from Counter; worth putting in a mixin?

  def value
    v = connection.get(key)
  rescue Memcached::NotFound
    if block
      value = block.call
      value
    end
  end

  # NOTE: this will overwrite any existing key
  def value=(v)
    connection.set(key, v)
  end

  def reset
    connection.delete(key)
  rescue Memcached::NotStored
    # AKK: do something here?
  end

end

