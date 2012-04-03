require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/config/db/recall.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, required: true
  property :complete, Boolean, required: true, default: false
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end
