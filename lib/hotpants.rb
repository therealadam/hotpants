require "memcached"
require "active_support/concern"

module Hotpants

  autoload :Counter, "hotpants/counter"
  autoload :Index, "hotpants/index"
  autoload :Value, "hotpants/value"

  extend ActiveSupport::Concern
  included do

    def self.value(name)
      class_eval <<-RUBY, __FILE__, __LINE__
        def #{name}
          values[:#{name}].value
        end

        def #{name}=(value)
          values[:#{name}].value = value
        end
      RUBY
    end

    def self.counter(name)
      class_eval <<-RUBY, __FILE__, __LINE__
        def #{name}
          counters[:#{name}]
        end
      RUBY
    end

    def self.index(name)
      class_eval <<-RUBY, __FILE__, __LINE__
        def #{name}
          indexes[:#{name}]
        end
      RUBY
    end

    protected

    def values
      @values ||= Hash.new do |hsh, k|
        hsh[k] = Hotpants::Value.new(k.to_s, $memcached)
      end
    end

    def counters
      @counters ||= Hash.new do |hsh, k|
        hsh[k] = Hotpants::Counter.new(k.to_s, $memcached)
      end
    end

    def indexes
      @indexes ||= Hash.new do |hsh, k|
        hsh[k] = Hotpants::Index.new(k.to_s, $memcached)
      end
    end
  end

end

