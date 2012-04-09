require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/config/db/recall.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, required: true
  property :complete, Boolean, required: true, default: false
  property :user, Text, required: false 
  property :created_at, DateTime
  property :updated_at, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial 
  property :name, Text, required: true
  property :password, Text, required: true
end

DataMapper.finalize.auto_upgrade!

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def validate(user, password)
    u = User.first name: user
    return u.password == password
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
      u.password = password
      u.save
    end
    return "User already exists"
  end
end
