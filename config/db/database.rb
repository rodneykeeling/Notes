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
