module Api
  module V1
    class DnsRecordsController < ApplicationController
      before_action :validate_index, only: [:index]

      def index
        render json: {}, status: :ok
      end

      def create
        dns_record = DnsRecord.create(create_params[:dns_records])

        response = { data: { id: dns_record.id }, status: :created } if dns_record.persisted?
        response = { data: { errors: dns_record.errors }, status: :unprocessable_entity } if dns_record.invalid?

        render json: response[:data], status: response[:status]
      end

      private

      def validate_index
        return render json: { error: 'Required paramet PAGE was not provided' }, status: :unprocessable_entity unless params[:page]
      end

      def create_params
        params.permit(dns_records: [:id, :ip, hostnames_attributes: [:hostname]])
      end
    end
  end
end
