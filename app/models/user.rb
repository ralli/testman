class User < ActiveRecord::Base
  acts_as_authentic
  validates_presence_of :login
  validates_presence_of :email
  validates_length_of :login, :maximum => 20
  validates_length_of :email, :maximum => 80

  def display_name
    unless first_name.blank? or last_name.blank?
      "#{first_name} #{last_name}"
    else
      login
    end
  end
end
