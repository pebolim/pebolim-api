# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Para recriar a db rails db:setup

player1 = User.create(password:"46f94c8de14fb36680850768ff1b7f2a", nickname:"albert",age: 23);
player2 = User.create(password:"46f94c8de14fb36680850768ff1b7f2a", nickname:"josefa",age: 6);
player3 = User.create(password:"46f94c8de14fb36680850768ff1b7f2a", nickname:"sexyboy",age: 31);
player4 = User.create(password:"46f94c8de14fb36680850768ff1b7f2a", nickname:"cebola",age: 12);


team1 = Team.create(name:"Reis dos matrecos",attacker:player1["id"], defender:player2["id"]);
team2 = Team.create(name:"Abébias Clube de Portugal",attacker:player3["id"],defender:player4["id"]);
team3 = Team.create(name:"Roscas e Pregos",attacker:player1["id"],defender:player3["id"]);
team4 = Team.create(name:"Qualquercoisa",attacker:player2["id"],defender: player4["id"]);

gamestate1 = GameState.create(name:"finished");
gamestate2 = GameState.create(name:"finished");

game1 = CasualGame.create(local:"IPT",match_day:DateTime.new(2018,9,19,17,30),url: "someURL",is_private: false,max_goals: 5,result1: 5,result2: 3,finish_date: DateTime.new(2018,9,19,17,30),best_atacker: 1,best_defender: 2,game_state_id: gamestate1["id"],owner_id: player1["id"],team1_id: team1["id"],team2_id:team2["id"]);
game2= CasualGame.create(local:"IPT",match_day:DateTime.new(2018,10,19,17,30),url: "someURL",is_private: false,max_goals: 3,result1: 3,result2: 0,finish_date: DateTime.new(2018,10,19,17,30),best_atacker: 3,best_defender: 1,game_state_id: gamestate2["id"],owner_id: player3["id"],team1_id: team3["id"],team2_id:team4["id"])

=begin
gameGoals = CasualGoal.create(game_id:game1,player_id:team1["attacker"])



teams = Team.all
games = Game.all

games.each do |g|
    t = teams.sample(2)
    TeamGame.create(team: t[0] ,game: g, winner: true, score: rand(4))
    TeamGame.create(team: t[1] ,game: g, winner: false, score: rand(4))
end


team1.players << [player1,player2]
team2.players << [player3,player4]

team3.players << [player3,player2]
team4.players << [player1,player4]
=end