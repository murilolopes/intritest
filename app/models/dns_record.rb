class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames
  has_many :dns_records_hostnames

  validates_presence_of :ip

  accepts_nested_attributes_for :hostnames, allow_destroy: true
end
