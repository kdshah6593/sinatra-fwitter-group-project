class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect "/tweets"
        else
            erb :'/users/create_user'
        end
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect "/signup"
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect "/tweets"
        end
    end
    
    get '/login' do
        if logged_in?
            redirect "/tweets"
        else
            erb :'/users/login'
        end
    end
    
    post '/login' do
        @user = User.find_by(username: params[:username])
                
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get '/users/:id' do
        @user = User.find(params[:id])
        erb :'users/show'
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect "/login"
        else
            redirect '/'
        end
    end

end
