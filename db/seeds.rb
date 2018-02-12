# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create!(email: "a@a.com", password: "password")
u2 = User.create!(email: "a2@a.com", password: "password")
a1 = User.create!(email: "admin@gmail.com", password: "password", role: "admin")
r1 = Coin.create!(name: "BTC", picture: "https://bitcoin.org/img/icons/opengraph.png", description: "The Crypto Godfather", user: u1)
r2 = Coin.create!(name: "ETH", picture: "http://files.coinmarketcap.com.s3-website-us-east-1.amazonaws.com/static/img/coins/200x200/ethereum.png", user: u1)
r3 = Coin.create!(name: "LTC", picture: "http://files.coinmarketcap.com.s3-website-us-east-1.amazonaws.com/static/img/coins/200x200/litecoin.png", user: u1)
r4 = Coin.create!(name: "IOT", picture: "https://lh3.googleusercontent.com/EAay5f1pkrwK8j9RiuavOJl74T45osxw-h_WkUpLQHyDw4zlMDzuiccGA_xxZGsHPsd1=w300", user: u1)
r5 = Coin.create!(name: "XRB", picture: "https://res.cloudinary.com/teepublic/image/private/s--ZKQ2OCE0--/t_Preview/b_rgb:000000,c_limit,f_jpg,h_630,q_90,w_630/v1517464622/production/designs/2326834_0.jpg", user: u1)
comment1= Comment.create!(title: "Volatile coin", rating: "1",body:"Gained 1 mil on this coin and lost it all in 24 hours.", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r1.id, user_id: u1.id)
comment2= Comment.create!(title: "Unstable but amazing", rating: "5", body:"Bought all of my kids a lambo!", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r1.id, user_id: u2.id)
comment3= Comment.create!(title: "Stable Coin", rating: "4",body:"Doesn't have the exponential growth of BTC but very nice gains.", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r2.id, user_id: u2.id)
comment4= Comment.create!(title: "Slow but stady", rating: "5", body:"Solid investment backed by good technology", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r2.id, user_id: u2.id)
comment5= Comment.create!(title: "Odd coin", rating: "2", body: "Interesting coin, very promising", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r5.id, user_id: u2.id)
comment6= Comment.create!(title: "One of the OG's", rating: "3", body:"Kind of like bitcoins little brother.", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r3.id, user_id: u2.id)
comment7= Comment.create!(title: "Made good gains!", rating: "5", body:"Bought in at .05 and now its worth a ton!", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r3.id, user_id: u1.id)
comment8= Comment.create!(title: "Decent coin, shows promise.", rating: "3", body:"Made ok gains", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r5.id, user_id: u1.id)
comment9= Comment.create!(title: "Small coin big dreams", rating: "4", body:"Crypto dark horse, definitely worth investing in", date: "2017-10-10", initial_coin_deposit: "1", coin_id: r4.id, user_id: u1.id)
