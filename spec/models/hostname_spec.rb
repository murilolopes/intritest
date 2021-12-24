require 'rails_helper'

RSpec.describe Hostname, type: :model do
  it "is valid with valid attributes" do
    hostname = Hostname.new(hostname: 'intricately.com')
    expect(hostname).to be_valid
  end
  it "is not valid without a hostname" do
    hostname = Hostname.new
    expect(hostname).to_not be_valid
  end
end
