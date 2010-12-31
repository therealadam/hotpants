class Hotpants::Counter

  attr_accessor :connection, :key

  def initialize(key, connection)
    self.connection = connection
    self.key = key
  end

  def value
    v = connection.get(key, false)
    Integer(v)
  rescue Memcached::NotFound
    nil
  end

  # NOTE: this will overwrite any existing key
  def value=(v)
    # AKK: 0 is no TTL
    connection.set(key, v, 0, false)
  end

  def reset
    connection.delete(key)
  rescue Memcached::NotStored
    # AKK: do something here?
  end

  def incr(count=1)
    connection.increment(key, count)
  end

  def decr(count=1)
    connection.decrement(key, count)
  end

end

