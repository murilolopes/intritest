module Api
  module V1
    class DnsRecordsController < ApplicationController
      before_action :validate_index, only: [:index]

      def index

      end

      # POST /dns_records
      def create
        # TODO: Implement this action
      end

      private

      def validate_index
        return render json: { error: 'Required paramet PAGE was not provided' }, status: :unprocessable_entity unless params[:page]
      end
    end
  end
end
