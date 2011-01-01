require "helper"

describe Hotpants::Index do
  
  subject { Hotpants::Index.new("users", memcached) }

  it "has a key prefix" do
    subject.prefix.should == "users"
  end

  it "indexes an object" do
    subject["adam"] = "handsome"
    subject["adam"].should == "handsome"
  end

end
