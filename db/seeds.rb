# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Billboard.create([
                     {id: 10, address: "улица Немига 28", price_id: 1},
                     {id: 11, address: "проспект Пушкина 34", price_id: 7},
                     {id: 12, address: "Полицейский мост", price_id: 3},
                     {id: 13, address: "проспект Машерова 53", price_id: 4},
                     {id: 14, address: "улица Максима Богдановича 46", price_id: 5},
                     {id: 16, address: "Брилевская 5", price_id: 6}
                 ])
Price.create([
                 {billboard_id: 10, price: 200},
                 {billboard_id: 11, price: 150},
                 {billboard_id: 12, price: 200},
                 {billboard_id: 13, price: 180},
                 {billboard_id: 14, price: 180},
                 {billboard_id: 16, price: 110},
                 {billboard_id: 11, price: 170},
             ])
BillboardEmployment.create([
                               {id: 1, body: "Такой большой", brand: "mcdonalds", adv_type: "commercial",
                                duration: 5, start__date: "2019-11-11", billboard_id: 10, user_id: 10 active: 1},
                               {id: 2, body: "Автосалон", brand: "masterok", adv_type: "commercial",
                                duration: 2, start__date: "2019-10-29", billboard_id: 13, user_id: 12, active: 0},
                               {id: 8, body: "Velcom становится А1", brand: "A1", adv_type: "commercial",
                                duration: 5, start__date: "2019-11-20", billboard_id: 14, user_id: 13, active: 0},
                               {id: 9, body: "Соблюдайте скорость", brand: "ГАИ", adv_type: "social",
                                duration: 2, start__date: "2019-10-29", billboard_id: 11, user_id: 10, active: 0},
                               {id: 10, body: "ЭкоЛОГИЧНО?", brand: "Охрана природы", adv_type: "social",
                                duration: 3, start__date: "2019-03-15", billboard_id: 12, user_id: 12, active: 0},
                               {id: 14, body: "Coca-colaaa", brand: "Cola", adv_type: "commercial",
                                duration: 1, start__date: "2019-08-12", billboard_id: 12, user_id: 13, active: 0},
                           ])
Comment.create([
              {nickname: dmitry22,body: "Мне нравится",billboard_id:10},
              {body: "Хорошая локация",billboard_id:10}
               ])