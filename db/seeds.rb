# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PlayerTeam.delete_all
Team.delete_all
Game.delete_all
Player.delete_all

player1 = Player.create(name: "Alberto António",    password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", username:"albert",     score: 23);
player2 = Player.create(name: "Maria Josefa",       password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", username:"josefa",     score: 6);
player3 = Player.create(name: "Rui Unas",           password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", username:"sexyboy",    score: 31);
player4 = Player.create(name: "Pedro Cebola",       password:"fbfb386efea67e816f2dda0a8c94a98eb203757aebb3f55f183755a192d44467", username:"cebola",     score: 12);

game1 = Game.create(matchDay: DateTime.new(2018,9,19,17,30) );
game2 = Game.create(matchDay: DateTime.new(2018,10,7,15,40) );

team1 = Team.create(game: game1);
team2 = Team.create(game: game1);
team3 = Team.create(game: game2);
team4 = Team.create(game: game2);

PlayerTeam.create([
    {team: team1, player:player1},
    {team: team1, player:player2},
    {team: team2, player:player3},
    {team: team2, player:player4},
    {team: team3, player:player1},
    {team: team3, player:player3},
    {team: team4, player:player2},
    {team: team4, player:player4},
]);