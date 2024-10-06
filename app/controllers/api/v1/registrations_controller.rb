# app/controllers/api/v1/registrations_controller.rb
module API
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      include API::Concerns::ActAsAPIRequest
      protect_from_forgery with: :null_session
      before_action :check_user_existence, only: [:create]
      before_action :send_otp_for_phone_number_verification, only: [:create]

      private

      def check_user_existence
        if User.find_by(phone_number: sign_up_params[:phone_number])
          render json: { error: 'User already exists' }, status: :unprocessable_entity
          return
        end
      end

      def send_otp_for_phone_number_verification
        phone_number = sign_up_params[:phone_number]

        # Call the OtpService to send OTP
        OtpService.new(phone_number).send_otp
      end

      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :status)
      end
    end
  end
end
