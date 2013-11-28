class App < Sinatra::Base
  
  before do
    @program_count = Program.count :is_active => true
    @timestamp = TIMESTAMP
  end
  
  get '/local' do
    session[:hit_local_splash] = true
    @uploaded_music = params[:thank] == 'you' ? true : false
    @program_count = Program.count :is_active => true
    erb :'local', :layout => false
  end
 
  get '/listen_live/?' do
    erb :'listen_live', :layout => false
  end
 
  get '/local_songs' do
    puts request.inspect
    @local_songs = LocalSong.all :order => [:created_at.desc]
    erb :'/local_songs/index', :layout => false
  end
  
  get '/local_songs/all.m3u' do
    content_type :m3u
    @local_songs = LocalSong.all :order => [:created_at.desc]
    @local_songs.collect {|local_song| "http://houseofsound.org/local_songs/#{local_song.id}.mp3\n"}.join('')
  end
  
  get '/local_songs/:id.mp3.m3u' do
    content_type :m3u
    @local_song = LocalSong.get params[:id]
    puts "http://#{request.host}/local_songs/#{@local_song.id}.mp3"
    "http://houseofsound.org/local_songs/#{@local_song.id}.mp3"
  end
  
  get '/local_songs/:id.mp3' do
    @local_song = LocalSong.get params[:id]
    content_type :mp3
    response.headers['Content-Disposition'] = "attachment; filename=\"#{@local_song.artist_name.strip_non_characters} - #{@local_song.title.strip_non_characters}.mp3\""
    send_file File.join(@local_song.file_path)
  end
 
  post '/local_songs' do
    LocalSong.create params[:local_song]
    redirect '/local?thank=you'
  end
  
  get '/?' do
    redirect '/iphone' if request.user_agent =~ /iPhone/
    # redirect '/local' unless session[:hit_local_splash]
    @program = Program.current
    erb :index
  end
  
  get '/front' do
    @program = Program.current
    @programs = Program.all_for_day Time.now.strftime('%w')
    erb :index
  end
  
  get '/paypal' do
    @program = Program.current
    @programs = Program.all_for_day Time.now.strftime('%w')
    erb :paypal
  end

  get '/iphone' do
    erb :'iphone', :layout => false
  end

  get '/googledbc69db47b40aee8.html' do
    erb :'google', :layout => false
  end

  get '/iphone.php' do
    erb :'iphone', :layout => false
  end
  
  get '/programs' do
    @day_of_week = Date::DAYNAMES.index(params[:day_of_week]) || Time.now.strftime('%w').to_i
    @programs = Program.all_for_day @day_of_week, :is_active => true
    erb :'programs/index'
  end
  
  get '/programs/all' do
    @programs = Program.all_active
    erb :'programs/all'
  end
  
  get '/programs/:id' do
    @program = Program.get params[:id].split('-')[0]
    erb :'programs/show'
  end
  
  get '/programs/calendar' do
    @programs = Program.all
  end
  
  get '/shows/:id/:filename' do
    @show = Show.get params[:id].split('-')[0]
    content_type :mp3
    response.headers['Content-Disposition'] = "attachment; filename=\"House of Sound - #{@show.program.name.strip_non_characters} - #{@show.when.strftime("%B %d")}.mp3\""
    send_file File.join(self.class.public, @show.file_public_path)
  end
  
  get '/apply' do
    @apply = OpenStruct.new
    erb :apply
  end
  
  post '/apply' do
    filled_out_all_values = true
    params[:apply].each {|k,v| filled_out_all_values = false if v.empty?}
    
    if filled_out_all_values
      body = ''
      params[:apply].each_pair {|k,v| body << "#{k.gsub '_', ' '}:\n#{v}\n\n"}
      
#      Pony.mail :to => ADMIN_TO_EMAIL, 
#                :cc => ADMIN_CC_EMAILS, 
#                :subject => 'House of Sound Application', 
#                :body => body,
#                :via => :sendmail

      send_email params[:apply][:email], '[House of Sound] Application sent from site', body

      erb '<h1><a href="/">Thank you, I have sent out your application. You will be contacted shortly.</a></h1>'
    else
      @apply = OpenStruct.new params[:apply]
      @error_message = 'Please correctly fill out all values on this form.'
      erb :apply
    end
  end
  
  get '/contact' do
    @contact = OpenStruct.new
    erb :contact
  end
  
  post '/contact' do
    filled_out_all_values = true
    params[:contact].each {|k,v| filled_out_all_values = false if v.empty?}
    
    if filled_out_all_values && params[:contact][:blue_meanies_are].downcase == 'blue' && valid_email?(params[:contact][:email])
      body = ''
      params[:contact].each_pair {|k,v| body << "#{k.gsub '_', ' '}:\n#{v}\n\n"}
      
      send_email params[:contact][:email], '[House of Sound] Contact message sent from site', body

      erb '<h1><a href="/">Thank you, I have sent out your message.</a></h1>'
    else
      @contact = OpenStruct.new params[:contact]
      @error_message = ''
      @error_message = 'Please correctly fill out all values on this form. ' unless filled_out_all_values
      @error_message += 'Please use a real e-mail address. ' if !valid_email?(params[:contact][:email]) && filled_out_all_values
      @error_message += 'Try answering the anti-spam question again.' if params[:contact][:blue_meanies_are].downcase != 'blue' && filled_out_all_values
      erb :contact
    end
  end

  get '/boxee/?' do
    erb :'boxee/index'
  end

  private
  
  def valid_email?(email)
    email =~  /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
  end
  
  def send_email(from_email, subject, body)
    Pony.mail :from => from_email,
              :to => ADMIN_TO_EMAIL,
              :cc => ADMIN_CC_EMAILS, 
              :subject => subject, 
              :body => body,
              :via => :smtp,
              :via_options => {
                :address              => 'smtp.sendgrid.net',
                :port                 => '587',
                :enable_starttls_auto => true,
                :user_name            => 'kyle@houseofsound.org',
                :password             => 'cad4shiva',
                :authentication       => :plain,
                :domain               => 'houseofsound.org'
              }
  end
end
