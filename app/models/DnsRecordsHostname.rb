class DnsRecordsHostname < ApplicationRecord
  belongs_to :dns_records
  belongs_to :hostnames
end
