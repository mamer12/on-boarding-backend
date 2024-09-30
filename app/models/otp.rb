# == Schema Information
#
# Table name: otps
#
#  id           :bigint           not null, primary key
#  phone_number :string
#  otp          :string
#  expires_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Otp < ApplicationRecord
end
