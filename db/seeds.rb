# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.delete_all
Game.delete_all
Player.delete_all

player1 = Player.create(name: "Alberto António",    password:"46f94c8de14fb36680850768ff1b7f2a", username:"albert",     age: 23);
player2 = Player.create(name: "Maria Josefa",       password:"46f94c8de14fb36680850768ff1b7f2a", username:"josefa",     age: 6);
player3 = Player.create(name: "Rui Unas",           password:"46f94c8de14fb36680850768ff1b7f2a", username:"sexyboy",    age: 31);
player4 = Player.create(name: "Pedro Cebola",       password:"46f94c8de14fb36680850768ff1b7f2a", username:"cebola",     age: 12);

game1 = Game.create(match_day: DateTime.new(2018,9,19,17,30),local: "IPT", is_private: false; );
game2 = Game.create(matchDay: DateTime.new(2018,10,7,15,40),local: "IPT", is_private: true; );

team1 = Team.create();
team2 = Team.create();
team3 = Team.create();
team4 = Team.create();



