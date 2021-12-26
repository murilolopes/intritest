module Api
  module V1
    class DnsRecordsController < ApplicationController
      before_action :validate_index, only: [:index]

      def index
        dns_query = DnsRecord.page(params[:page]).per(5)

        if params[:included]
          hostnames_ids = Hostname.where(hostname: params[:included].split(",")).pluck(:id)
          dns_query = dns_query.joins(:dns_records_hostnames).where('dns_records_hostnames.hostname_id', hostnames_ids)
        end

        hostname_query = Hostname.joins(:dns_records_hostnames).where('dns_records_hostnames.dns_record_id in (?)', dns_query.pluck(:id)).uniq

        response = {
          total_records: dns_query.count,
          records: dns_query.map { |record| { id: record.id, ip_address: record.ip } },
          related_hostnames: hostname_query.map { |hostname| related_hostnames(hostname) }
        }

        render json: response, status: :ok
      end

      def create
        dns_record = DnsRecord.find_or_create_by(ip: create_params[:dns_records][:ip])

        create_params[:dns_records][:hostnames_attributes].each do |hostname|
          dns_record.hostnames << Hostname.find_or_create_by(hostname: hostname[:hostname])
        end if dns_record.valid?

        response = { data: { id: dns_record.id }, status: :created } if dns_record.persisted?
        response = { data: { errors: dns_record.errors }, status: :unprocessable_entity } if dns_record.invalid?

        render json: response[:data], status: response[:status]
      end

      private

      def validate_index
        render json: { error: 'Required paramet PAGE was not provided' }, status: :unprocessable_entity unless params[:page]
      end

      def create_params
        params.permit(dns_records: [:id, :ip, hostnames_attributes: [:hostname]])
      end

      def related_hostnames(hostname)
        { count: hostname.dns_records_hostnames.count, hostname: hostname.hostname }
      end
    end
  end
end
