# app/services/otp_service.rb
class OtpService
  API_URL = 'https://gateway.standingtech.com/api/v4/sms/send'

  def initialize(phone_number)
    @phone_number = phone_number
  end

 def send_otp
  otp_value = generate_otp
  expires_at = 5.minute.from_now

  # Store OTP in the database
  Otp.create!(phone_number: @phone_number, otp: otp_value, expires_at: expires_at)

  # Send OTP via WhatsApp
  uri = URI(API_URL) # Ensure this includes HTTPS
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  #TODO : remove after deployment
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE # Temporarily disable SSL verification


  request = Net::HTTP::Post.new(uri.path, {
    'Content-Type' => 'application/json',
    'Authorization' => "Bearer #{ENV['OTP_PROVIDER_TOKEN']}"
  })

  request.body = {
    recipient: @phone_number,
    sender_id: 'FFC',
    type: 'whatsapp',
    message: "#{otp_value}",
    lang: 'ar'
  }.to_json

  begin
    # Perform the request and capture the response
    response = http.request(request)

  end
end



  def self.verify_otp(phone_number, otp_value)
    otp_record = Otp.find_by(phone_number: phone_number, otp: otp_value)

    # Check if the OTP exists and hasn't expired
    if otp_record && otp_record.expires_at > Time.now
      otp_record.destroy # Optionally delete the OTP after successful verification
      true
    else
      false
    end
  end

  private

  def generate_otp
    rand(100000..999999).to_s
  end
end
