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

games = Game.create();

Team.create([ {game: games},{ game:games} ]);