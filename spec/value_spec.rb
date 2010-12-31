require "helper"

describe Hotpants::Value do

  subject { Hotpants::Value.new("hotpants_value", memcached) }

  it "has a key" do
    subject.key.should == "hotpants_value"
  end

  it "has a value" do
    subject.value = "BOOM"
    subject.value.should == "BOOM"
  end

  it "executes an optional block to populate missing values" do
    subject.block = lambda { "zonk!" }
    subject.reset
    subject.value.should == "zonk!"
  end

  it "resets the value" do
    subject.value = "BANG!"
    subject.reset
    subject.value.should == nil
  end

end
