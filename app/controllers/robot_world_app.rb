require 'models/robot_repository'

class RobotWorldApp < Sinatra::Base
    # Sinatra configuration
    set :root, File.join(File.dirname(__FILE__), "..")
    set :method_override, true

    get "/" do
      haml :dashboard
    end

    get "/robots" do
        @robots = RobotRepository.all
        haml :index
    end

    post "/robots" do
      RobotRepository.create(params[:robot])
      redirect "/robots"
    end

    get "/robots/new" do
      haml :new
    end

    get "/robots/:id" do |id|
      @robot = RobotRepository.find(id.to_i)
      haml :show
    end

    put "/robots/:id" do |id|
      RobotRepository.update(id.to_i, params[:robot])
      redirect "/robots/#{id}"
    end

    get "/robots/:id/edit" do |id|
      @robot = RobotRepository.find(id.to_i)
      haml :edit
    end

    delete "/robots/:id" do |id|
      RobotRepository.delete(id.to_i)
      redirect "/robots"
    end
end
