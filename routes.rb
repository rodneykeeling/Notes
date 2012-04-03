# GET requests

# home
get '/' do
  @notes = Note.all order: :id.desc
  @title = 'All Notes'
  @list_idea = ['Buy milk.', 
                'Do your homework.', 
                'Clean your room.',
                'Send flowers to your mom.',
                'Feed the dog.'].sample
  erb :home
end

# edit note
get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note ##{params[:id]}"
  erb :edit
end

# delete note
get '/:id/delete' do
  @note = Note.get params[:id]
  @title = "Delete note ##{params[:id]}"
  erb :delete
end

# mark note as complete
get '/:id/complete' do
  n = Note.get params[:id]
  n.complete = n.complete ? 0 : 1
  n.updated_at = Time.now
  n.save
  redirect '/'
end


# POST requests

# insert new note
post '/' do
  n = Note.new
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
  redirect '/'
end


# PUT requests

# get note
put '/:id' do
  n = Note.get params[:id]
  n.content = params[:content]
  n.complete = params[:complete] ? 1 : 0
  n.updated_at = Time.now
  n.save
  redirect '/'
end


# DELETE requests

# delete note
delete '/:id' do
  n = Note.get params[:id]
  n.destroy
  redirect '/'
end


