class UserSession
  include ActiveModel::Validations
  include ActiveModel::Naming

  attr_accessor :login, :password

  validates_presence_of :login
  validates_presence_of :password

  def to_key
    @self
  end

  def model_name
    "Login"
  end

  def initialize(params = {})
    @login = params[:login]
    @password = params[:password]
  end
end

