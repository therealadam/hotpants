require "helper"

describe Hotpants do

  subject do
    $memcached = Memcached.new("localhost:11211")

    klass = Class.new do
      include Hotpants

      value :gadget
      counter :frobbings
      index :users
    end
    klass.new
  end

  it "defines a method for manipulating counters" do
    subject.frobbings.value = 14
    subject.frobbings.incr
    subject.frobbings.value.should == 15
  end

  it "defines a method for manipulating indexes" do
    # AKK: need a real use case here
    subject.users["adam"] = "gizmo"
    subject.users["adam"].should == "gizmo"
  end

  it "defines a method for manipulating values" do
    subject.gadget = "The Gadget"
    subject.gadget.should == "The Gadget"
  end

end
