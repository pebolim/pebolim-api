# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Para recriar a db rails db:setup

player1 = User.create(email:"yepz@a.a",password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", nickname:"yEPZ",age: 23,image_url: "http://blog.opovo.com.br/portugalsempassaporte/wp-content/uploads/sites/42/2013/07/Scolari.jpg");
player2 = User.create(email:"sexyboy@a.a",password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", nickname:"sexyboy",age: 31);
player3 = User.create(email:"teste@a.a",password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", nickname:"teste",age: 99,image_url: "http://c2.thejournal.ie/media/2015/09/monkey-selfie-1-310x415.jpg");
player4 = User.create(email:"rafescu@a.a",password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", nickname:"rafescu",age: 12);

team1 = Team.create(name:"Reis dos matrecos", is_official:true);
team2 = Team.create(name:"Abébias Clube de Portugal", is_official:true);
team3 = Team.create(name:"Roscas e Pregos", is_official:true);
team4 = Team.create(name:"Qualquercoisa", is_official:true);
team5 = Team.create(name:"Mancos Marretas Maricas", is_official:true);
team6 = Team.create(name:"Vitóra de Tomar", is_official:true);

partn1= Partnership.create(team:team1, user:player1, state:3);
partn2= Partnership.create(team:team1, user:player2, state:3);
partn3= Partnership.create(team:team2, user:player1, state:3);
partn4= Partnership.create(team:team2, user:player3, state:3);
partn5= Partnership.create(team:team3, user:player1, state:3);
partn6= Partnership.create(team:team3, user:player4, state:3);
partn7= Partnership.create(team:team4, user:player2, state:3);
partn8= Partnership.create(team:team4, user:player3, state:3);
partn9= Partnership.create(team:team5, user:player2, state:3);
partn10= Partnership.create(team:team5, user:player4, state:3);
partn11= Partnership.create(team:team6, user:player4, state:3);
partn12= Partnership.create(team:team6, user:player3, state:3);


game1= Game.create(local:"IPT",match_day:DateTime.new(2018,12,19,17,30),url: "someURL", state:1, owner:player1, is_private:false);
game2= Game.create(local:"IPT",match_day:DateTime.new(2018,10,19,17,30),url: "someURL", state:3, owner:player2);
game3= Game.create(local:"IPT",match_day:DateTime.new(2018,11,19,17,30),url: "someURL", state:3, owner:player3);
game4= Game.create(local:"IPT",match_day:DateTime.new(2018,12,19,18,30),url: "someURL", state:3, owner:player4);
game5= Game.create(local:"IPT",match_day:DateTime.new(2018,10,19,18,30),url: "someURL", state:3, owner:player1);
game6= Game.create(local:"IPT",match_day:DateTime.new(2018,11,19,18,30),url: "someURL", state:3, owner:player3);

part1= Participation.create(game:game1, team:team1, is_winner:false, goals:0);
part2= Participation.create(game:game1, team:team6, is_winner:true, goals:3);
part3= Participation.create(game:game2, team:team2, is_winner:false, goals:2);
part4= Participation.create(game:game2, team:team5, is_winner:true, goals:3);
part5= Participation.create(game:game3, team:team3, is_winner:false, goals:0);
part6= Participation.create(game:game3, team:team4, is_winner:true, goals:3);
part7= Participation.create(game:game4, team:team3, is_winner:false, goals:1);
part8= Participation.create(game:game4, team:team4, is_winner:true, goals:3);
part9= Participation.create(game:game5, team:team1, is_winner:false, goals:2);
part10= Participation.create(game:game5, team:team6, is_winner:true, goals:3);
part11= Participation.create(game:game6, team:team2, is_winner:false, goals:1);
part12= Participation.create(game:game6, team:team5, is_winner:true, goals:3);

goal01= Goal.create(game: game1, user: player4, time:2);
goal02= Goal.create(game: game1, user: player4, time:1);
goal03= Goal.create(game: game1, user: player3, time:3);
goal04= Goal.create(game: game2, user: player1, time:1);
goal05= Goal.create(game: game2, user: player4, time:9);
goal06= Goal.create(game: game2, user: player3, time:10);
goal07= Goal.create(game: game2, user: player4, time:4);
goal08= Goal.create(game: game2, user: player4, time:1);
goal09= Goal.create(game: game3, user: player2, time:2);
goal10= Goal.create(game: game3, user: player2, time:3);
goal11= Goal.create(game: game3, user: player3, time:11);
goal12= Goal.create(game: game4, user: player1, time:2);
goal13= Goal.create(game: game4, user: player2, time:3);
goal14= Goal.create(game: game4, user: player2, time:3);
goal15= Goal.create(game: game4, user: player3, time:5);
goal16= Goal.create(game: game5, user: player3, time:1);
goal17= Goal.create(game: game5, user: player4, time:3);
goal18= Goal.create(game: game5, user: player2, time:4);
goal19= Goal.create(game: game5, user: player2, time:4);
goal20= Goal.create(game: game5, user: player4, time:5);
goal21= Goal.create(game: game6, user: player4, time:6);
goal22= Goal.create(game: game6, user: player2, time:7);
goal23= Goal.create(game: game6, user: player3, time:10);
goal24= Goal.create(game: game6, user: player4, time:12);


=begin
gamegoal01= Goals = Casualgoal01= Goal.create(game_id:game1,player_id:team1["attacker"])



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