require 'spec_helper'

describe "battleship" do
  it "plays out a simple game" do
    b = Battleship.new
    g = b.create_game
    b.start_game g

    b.submit_turn g, g[:player1], {:turnType => "placement", :x => 0, :y => 0, :size => 5, :horizontal => true}
    b.submit_turn g, g[:player1], {:turnType => "placement", :x => 0, :y => 1, :size => 4, :horizontal => true}
    b.submit_turn g, g[:player1], {:turnType => "placement", :x => 0, :y => 2, :size => 3, :horizontal => true}
    b.submit_turn g, g[:player1], {:turnType => "placement", :x => 0, :y => 3, :size => 3, :horizontal => true}
    b.submit_turn g, g[:player1], {:turnType => "placement", :x => 0, :y => 4, :size => 2, :horizontal => true}

    b.submit_turn g, g[:player2], {:turnType => "placement", :x => 0, :y => 0, :size => 5, :horizontal => true}
    b.submit_turn g, g[:player2], {:turnType => "placement", :x => 0, :y => 1, :size => 4, :horizontal => true}
    b.submit_turn g, g[:player2], {:turnType => "placement", :x => 0, :y => 2, :size => 3, :horizontal => true}
    b.submit_turn g, g[:player2], {:turnType => "placement", :x => 0, :y => 3, :size => 3, :horizontal => true}
    b.submit_turn g, g[:player2], {:turnType => "placement", :x => 0, :y => 4, :size => 2, :horizontal => true}

    b.submit_turn g, g[:player1], {:turnType => "salvo", :coords => [ "0,0", "1,0", "2,0", "3,0", "4,0" ]} # 5 hits
    b.submit_turn g, g[:player2], {:turnType => "salvo", :coords => [ "0,0", "1,0", "2,0", "3,0" ]} # 4 hits

    b.submit_turn g, g[:player1], {:turnType => "salvo", :coords => [ "0,1", "1,1", "2,1", "3,1" ]} # 4 hits
    b.submit_turn g, g[:player2], {:turnType => "salvo", :coords => [ "0,0", "1,0", "2,0" ]} # 0 hits

    b.submit_turn g, g[:player1], {:turnType => "salvo", :coords => [ "0,2", "1,2", "2,2" ]} # 3 hits
    b.submit_turn g, g[:player2], {:turnType => "salvo", :coords => [ "0,0", "1,0" ]} # 0 hits

    b.submit_turn g, g[:player1], {:turnType => "salvo", :coords => [ "0,3", "1,3", "2,3" ]} # 3 hits
    b.submit_turn g, g[:player2], {:turnType => "salvo", :coords => [ "0,0" ]} # 0 hits

    b.submit_turn g, g[:player1], {:turnType => "salvo", :coords => [ "0,4", "1,4" ]} # 2 hits

    (b.game_status g)['Phase'].should == "finished"
  end
end
