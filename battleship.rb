require 'httparty'

class Battleship
  include HTTParty

  def initialize base_uri = 'localhost:8080'
    self.class.base_uri base_uri
  end

  def create_player name="Player#{rand(10000)}"
    data = self.class.post '/players', query: { name: name }

    return { playerKey: data['PlayerKey'] }
  end

  def create_game player1 = create_player, player2 = create_player
    data = self.class.post '/games', query: { player1: player1[:playerKey], player2: player2[:playerKey] }

    return { gameID: data['GameID'], player1: player1, player2: player2 }
  end

  def start_game game
    data = self.class.post "/games/#{game[:gameID]}/start"

    p data.body
  end

  def submit_turn game, player, turnData
    data = self.class.post "/games/#{game[:gameID]}/turns", query: { playerKey: player[:playerKey] }.merge(turnData)

    p data.body
  end

  def game_status game
    data = self.class.get "/games/#{game[:gameID]}"

    data
  end
end
