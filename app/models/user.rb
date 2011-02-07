class User < ActiveRecord::Base
  acts_as_authentic
  validates_presence_of :login
  validates_presence_of :email
  validates_length_of :login, :maximum => 20
  validates_length_of :email, :maximum => 80

  belongs_to :current_project, :class_name => 'Project'

  attr_accessible :login, :first_name, :last_name, :email, :password, :password_confirmation, :current_project, :locale

  def to_label
    display_name
  end

  def display_name
    unless first_name.blank? or last_name.blank?
      "#{first_name} #{last_name}"
    else
      login
    end
  end

  def role_symbols
    [:admin]
  end
end

