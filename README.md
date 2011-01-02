# "Hotpants! Make ya sure of yourself. Good lord!"

Hotpants lets you add caching to your existing model classes. As your app grows, you often find yourself needing to keep counters, expensive calculations, and even indexes for common queries in memory. Memcached makes that possible, Hotpants makes it really easy to do. 

Here's an example model:

    class User < AR::Base
      include Hotpants
      
      counter :friends

      value :something, :with => :calculate_something
      index :username
    end

Counters are atomically modified values in memcached. Value are simple values you want to store in memcached. An index is a lookup table for the named attribute of the host model. A lock is a semaphore maintained by memcached. 

Hotpants is heavily influenced by redis-objects and several chats with John Nunemaker and Jesse Newland. 

## TODO

Note: this is a spike on ideas I've been toying with. It is rated _not-production-ready_, _somewhat-practical_ by MPAA.

- Implement lists? (using prepend/append)
- Implement locks?
- Should it be possible to clear an entire index? Efficiently?
