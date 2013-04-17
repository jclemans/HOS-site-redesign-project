class Admin < Sinatra::Base
  
  use Rack::Auth::Basic do |username, password|
    [username, password] == [ADMIN_USER, ADMIN_PASS]
  end
  
  before do
    puts params.inspect if ENV['RACK_ENV'] == 'development'
  end
  
  configure do
    set :views, Proc.new { File.join(root, 'views', 'admin') }
  end
  
  get '/?' do
    erb :'index'
  end
  
  get '/programs/?' do
    @programs = Program.all_ordered_by_start
    erb :'programs/index'
  end
  
  get '/programs/new' do
    @program = Program.new
    erb :'programs/new'
  end
  
  post '/programs' do
    @program = Program.new params[:program]
    if @program.valid?
      @program.save
      SCHEDULER.reload! Program.all_active
      redirect '/admin/programs'
    else
      erb :'programs/new'
    end
  end
  
  get '/programs/:id/edit' do
    @program = Program.get params[:id]
    erb :'programs/edit'
  end
  
  put '/programs/:id' do
    @program = Program.get params[:id]
    @program.update params[:program]
    if @program.valid?
      @program.save
      SCHEDULER.reload! Program.all_active
      redirect '/admin/programs'
    else
      erb :'programs/edit'
    end
  end
  
  delete '/programs/:id' do
    @program = Program.get params[:id]
    @program.shows.each {|show| show.destroy }
    @program.destroy
    SCHEDULER.reload! Program.all_active
    redirect '/admin/programs'
  end
  
  get '/programs/:id/shows' do
    @program = Program.get params[:id]
    erb :'shows/index'
  end
  
  delete '/shows/:id' do
    @show = Show.get params[:id]
    @show.destroy
    redirect "/admin/programs/#{@show.program.id}/shows"
  end
  
end