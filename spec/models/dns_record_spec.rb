require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  it "is valid with valid attributes" do
    dnsRecord = DnsRecord.new(ip: '1.1.1.1')
    expect(dnsRecord).to be_valid
  end
  it "is not valid without a ip" do
    dnsRecord = DnsRecord.new
    expect(dnsRecord).to_not be_valid
  end
end
