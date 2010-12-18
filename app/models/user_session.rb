class UserSession < Authlogic::Session::Base
  def to_key
    nil
  end
end
