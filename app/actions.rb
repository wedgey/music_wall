helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  def logged_in?
    !current_user.nil?
  end

  def user_review?(review)
    review.user == current_user
  end

end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/music' do
  Music.connection
  @songs = Music.includes(:votes).references(:votes).group('"musics"."id"', '"votes"."id"').order('COUNT("votes"."id") DESC')
  # @songs = Music.joins(:votes).group("musics"."id").order('COUNT("votes"."id") DESC')
  erb :'music/index'
end

post '/music' do
  @music = Music.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )
  @music.user = current_user if logged_in?
  if @music.save
    redirect '/music'
  else
    erb :'music/new'
  end
end

get '/music/new' do
  @music = Music.new
  erb :'music/new'
end

get '/music/:id' do
  @music = Music.find(params[:id])
  erb :'music/details'
end

get '/music/:mid/review/delete/:id' do
  if logged_in?
    Review.find(params[:id]).destroy if user_review?(Review.find(params[:id]))
  end
  redirect '/music/' + params[:mid]
end

post '/music/review/new' do
  if logged_in?
    @review = Review.new(review: params[:review_text], stars: params[:num_stars])
    @review.music = Music.find(params[:id].to_i)
    @review.user = current_user
    @review.save!
  end
  redirect '/music/' + params[:id]
end

get '/music/upvote/:id' do
  if logged_in? && current_user.votes.where(music_id: params[:id]).empty?
    @vote = Vote.new
    @vote.user = current_user
    @vote.music = Music.find(params[:id])
    @vote.save!
    return params[:id]
  end
  # redirect '/music'
end

get '/music/downvote/:id' do
  if logged_in? && !current_user.votes.where(music_id: params[:id]).empty?
    current_user.votes.find_by(music_id: params[:id]).destroy
    return params[:id]
  end
end


post '/user' do
  if params[:password] == params[:password_confirm]
    @user = User.new(username: params[:username])
    @user.password = params[:password]
    if @user.save
      redirect '/music'
    else
      erb :'user/new'
    end
  else
    @missmatch = true
    @user = User.new
    erb :'user/new'
  end
end

get '/user/new' do
  @user = User.new
  erb :'user/new'
end

post '/user/login' do
  @user = User.find_by(username: params[:username])
  if @user && @user.password == params[:password]
    session[:user] = @user.id
  else
  end
  redirect '/music'
end

get '/user/logout' do
  session.delete(:user)
  redirect '/music'
end
