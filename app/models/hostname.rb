class Hostname < ApplicationRecord
  has_and_belongs_to_many :dns_records
  has_many :dns_records_hostnames

  validates_presence_of :hostname
end
