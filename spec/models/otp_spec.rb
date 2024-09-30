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
require 'rails_helper'

RSpec.describe Otp, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
