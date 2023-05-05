module SessionHelpers
  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
  end
end

RSpec.configure do |config|
  config.include SessionHelpers, type: :request
end