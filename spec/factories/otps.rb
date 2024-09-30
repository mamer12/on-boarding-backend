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
FactoryBot.define do
  factory :otp do
    phone_number { "MyString" }
    otp { "MyString" }
    expires_at { "2024-09-29 22:54:42" }
  end
end
