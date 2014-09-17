# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  show_name            :string(255)
#  is_vip               :boolean
#  grade                :string(255)
#  points               :integer
#  phone                :string(255)
#  hashed_password      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  avatar               :string(255)
#  authentication_token :string(255)
#

class User < ActiveRecord::Base
  def self.valid_password(email, password)
    return (email == Paibei::USER[:email] and password == Paibei::USER[:password])
  end

  def self.valid_user?(email)
    return email == Paibei::USER[:email]
  end
end
