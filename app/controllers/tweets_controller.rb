class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do #form for new tweet
        if logged_in?
            erb :'tweets/create_tweet'
        else
            redirect '/login'
        end
    end

    post '/tweets' do #form is direct to here to post tweet
        if logged_in?
            if !params[:content].empty?
                @tweet = Tweet.create(content: params[:content])
                @tweet.user = current_user
                @tweet.save
                redirect "/tweets/#{@tweet.id}"
            else
                redirect '/tweets/new'
            end
        else
            redirect '/login'
        end
    end
    
    get '/tweets/:id' do #displays info of tweet
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do #form for editing tweet
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'tweets/edit_tweet'
            else
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do #submit edited tweet
        if logged_in?
            if params[:content] == ""
                redirect "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find(params[:id])
                if @tweet && @tweet.user == current_user
                    @tweet.update(content: params[:content])
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect "/tweets"
                end
            end
        else
            redirect "/login"
        end
    end

    post '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user == current_user
                @tweet.destroy
            end
            redirect "/tweets"
        else
            redirect '/login'
        end
    end

end
