get '/' do
  @log_in_out = "login"
  erb :index
end

post '/short_url' do
  @log_in_out = "login"
  url = Url.find_by_full(params[:full])

  if url
    @short = url.short
    erb :short_url
  else 
    if Url.create(:full => params[:full], :users_id => session[:id]).valid?
      @short = Url.last.short
      erb :short_url
    else
      erb :invalid
    end
  end
end

get '/create' do
  erb :create
end

get '/login' do
  erb :login
end

post '/users' do
  session[:id] ||= nil
  user = User.authenticate(params[:email], params[:password])

  if user
    session[:id] = user.id
    @name = session[:user]
    redirect to "/users/:#{user.id}"
  else
    @error_message = "Oops, you didn't enter the right password or email"  
    erb :index
  end
end

post '/new_account' do
  user = User.create(params)
  if user.valid?
    session[:id] = user.id
    redirect to "/users/#{user.id}"
  else
    @error_message = "You fucked up!"
    erb :create
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :user_page
end

get '/:short_url' do
  url = Url.find_by_short(params[:short_url])
  url.click_count += 1
  url.save
  redirect to Url.find_by_short(params[:short_url]).full  
end





