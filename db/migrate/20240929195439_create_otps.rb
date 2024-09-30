class CreateOtps < ActiveRecord::Migration[7.2]
  def change
    create_table :otps do |t|
      t.string :phone_number
      t.string :otp
      t.datetime :expires_at

      t.timestamps
    end
  end
end
