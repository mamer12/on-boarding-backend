# app/controllers/api/v1/otps_controller.rb
# frozen_string_literal: true

module API
  module V1
    class OtpsController < API::V1::APIController
      # POST /otp/verify
      def verify
        phone_number = params[:phone_number]
        otp_value = params[:otp]

        if OtpService.verify_otp(phone_number, otp_value)
          render json: { message: 'OTP verified successfully' }, status: :ok
        else
          render json: { error: 'Invalid or expired OTP' }, status: :unprocessable_entity
        end
      end
    end
  end
end
