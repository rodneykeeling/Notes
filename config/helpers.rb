helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def validate(user, password)
    u = User.first name: user
    return BCrypt::Password.create(password) == u.password
  end
  def is_logged_in?
    session["logged_in"] == true
  end

  def clear_session
    session.clear
  end

  def get_user
    if is_logged_in? 
      session["username"] 
    else
      "<a href=\"/login\">Login</a> or <a href=\"/signup\">Sign up</a>"
    end
  end

  def create_user(user, password)
    u = User.first name: user
    if u.nil?
      u = User.new
      u.name = user
      u.password = BCrypt::Password.create(password)
      u.save
    end
    return "User already exists"
  end
end
