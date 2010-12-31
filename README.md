# "Hotpants! Make ya sure of yourself. Good lord!"

Hotpants lets you add caching to your existing model classes. As your app grows, you often find yourself needing to keep counters, expensive calculations, and even indexes for common queries in memory. Memcached makes that possible, Hotpants makes it really easy to do. 

Here's an example model:

    class User < AR::Base
      include Hotpants
      
      counter :friends
      value :something
      index :username
      lock :something
    end

Counters are atomically modified values in memcached. Value are simple values you want to store in memcached. An index is a lookup table for the named attribute of the host model. A lock is a semaphore maintained by memcached. 

Hotpants is heavily influenced by redis-objects and several chats with John Nunemaker and Jesse Newland. 
