# app/controllers/api/v1/registrations_controller.rb
module API
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      before_action :send_otp_for_phone_number_verification, only: [:create]

      private

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
