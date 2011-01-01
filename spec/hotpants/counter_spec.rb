require "helper"

describe Hotpants::Counter do

  subject { Hotpants::Counter.new("counter_spec", memcached) }

  it "is initialized with a memcached connection" do
    connection = memcached
    counter = Hotpants::Counter.new("some_key", connection)
    counter.connection.should == connection
  end

  it "has a key" do
    subject.key.should == "counter_spec"
  end

  it "has a cached value" do
    subject.value = 14
    subject.value.should == 14
  end

  it "resets the cached value" do
    subject.value = 17
    subject.value.should == 17
    subject.reset
    subject.value.should == nil
  end

  it "increments the cached value" do
    subject.value = 14
    subject.incr
    subject.value.should == 15

    subject.incr(10)
    subject.value.should == 25
  end

  it "decrements the cached value" do
    subject.value = 14
    subject.decr
    subject.value.should == 13

    subject.decr(10)
    subject.value.should == 3
  end

end
