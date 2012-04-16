enable :sessions

# GET requests

# home
get '/' do
  if is_logged_in?
    @notes = Note.all user: get_user, order: :id.desc
  else
    @notes = Note.all order: :id.desc 
  end
  @title = 'All Notes'
  @list_idea = ['Buy milk.', 
                'Do your homework.', 
                'Clean your room.',
                'Send flowers to mom.',
                'Do the dishes',
                'Feed the dog.'].sample
  erb :home
end

get '/all-users' do
  @title = 'All Users'
  @users = User.all
  erb :all
end

get '/:id.json' do
  note = Note.get params[:id]
  content_type :json
  note.to_json
end

get '/login' do
  @title = 'Login'
  erb :login
end

get '/logout' do
  clear_session
  @message = "You've been logged out."
  @notes = Note.all order: :id.desc
  @title = 'All Notes'
  @list_idea = ['Buy milk.', 
                'Do your homework.', 
                'Clean your room.',
                'Send flowers to your mom.',
                'Feed the dog.'].sample
  erb :home
end

get '/signup' do
  @title = 'Sign up'
  erb :signup
end

# edit note
get '/:id' do
  if is_logged_in?
    @note = Note.get params[:id]
    @title = "Edit note ##{params[:id]}"
    erb :edit
  else
    @note = Note.all order: :id.desc
    erb :home
  end
end

# delete note page
get '/:id/delete' do
  if is_logged_in?
    @note = Note.get params[:id]
    @title = "Delete note ##{params[:id]}"
    erb :delete
  else
    erb :home
  end
end

# mark note as complete
get '/:id/complete' do
  if is_logged_in?
    n = Note.get params[:id]
    n.complete = n.complete ? 0 : 1
    n.updated_at = Time.now
    n.save
  end
  redirect '/'
end

# POST requests

# insert new note
post '/' do
  if is_logged_in?
    n = Note.new
    n.content = params[:content]
    n.user = get_user
    n.created_at = Time.now
    n.updated_at = Time.now
    n.save
  end
  redirect '/'
end

post '/login' do
  @title = 'All Notes'
  @list_idea = ['Buy milk.', 
                'Do your homework.', 
                'Clean your room.',
                'Send flowers to your mom.',
                'Feed the dog.'].sample
  if(validate(params["username"], params["password"]))
    session["logged_in"] = true
    session["username"] = params["username"]
    @message = "You've been logged in.  Welcome back, #{params["username"]}"
    @notes = Note.all user: get_user, order: :id.desc
    redirect '/'
  else
    puts "error"
    @error_message = "Sorry, those credentials aren't valid."
    @notes = Note.all order: :id.desc
    redirect '/'
  end
end

post '/signup' do
  @title = 'My Notes'
  u = User.new
  u.name = params["username"]
  u.password = params["password"]
  u.save
  redirect '/login'
end

# PUT requests

# get note
put '/:id' do
  if is_logged_in?
    n = Note.get params[:id]
    n.content = params[:content]
    n.user = get_user
    n.complete = params[:complete] ? 1 : 0
    n.updated_at = Time.now
    n.save
  end
  redirect '/'
end


# DELETE requests

# delete note
delete '/:id' do
  if is_logged_in?
    n = Note.get params[:id]
    n.destroy
  end
  redirect '/'
end


