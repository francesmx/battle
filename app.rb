require 'sinatra/base'
require './lib/player'
require './lib/game'

class Battle < Sinatra::Base

  before do
    @game = Game.instance
  end

  get '/' do
    erb :index
  end

  post '/names' do
    player_1  = Player.new(params[:player_1_name])
    player_2  = Player.new(params[:player_2_name])
    @game = Game.create(player_1, player_2)
    redirect '/play'
  end

  get '/play' do
    if @game.game_over?
      redirect 'game_over'
    else
    end
    erb :play
  end

  get '/attack' do
    @game.attack(@game.opponent_of(@game.current_player))
    erb :attack
  end

  post '/switch' do
    @game.switch_player
    redirect '/play'
  end

  get '/game_over' do
    erb :game_over
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
