//
//  Post.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

struct Post {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int

    static func createPost() -> [Post] {

        var posts: [Post] = []

        let authors = ["Екатерина Кулешова", "Валентин Сонин", "Екатерина Кулешова", "Валентин Сонин", "Владимир Макаров", "Екатерина Кулешова"]

        let descriptions = [
            "Анонс новой игры NetherRealm может состояться в течение полугода — на это намекнул Эд Бун, творческий руководитель студии и создатель Mortal Kombat и Injustice.",
            "Пользователи сети обратили внимание, что сиквел «Человека-паука» Insomniac уже можно добавить в список желаемого PS Store — пока, правда, лишь в Британии.",
            "На канале IGN появился очередной ролик, посвящённый ремейку Dead Space. В этот раз разработчики игры из Motive Studios рассказали о том, какие изменения были внесены в плазменный резак.",
            "Актёр Камерон Монахэн, который играл Кэла Кестиса в Star Wars Jedi: Fallen Order, рассказал об эволюции своего героя в Star Wars Jedi: Survivor.",
            "Dwarf Fortress, на этой неделе вышедшая в Steam и за первые сутки выполнившая план продаж на два месяца, стартовала со второй строчки местного чарта, где товары и игры упорядочены по выручке за семь дней. Да, игра не смогла обойти Steam Deck.",
            "Нил Дракманн, геймдиректор обеих The Last of Us и Uncharted 4, подтвердил в своём Twitter-аккаунте, что The Last of Us: Part I выйдет на Steam Deck."
        ]

        let images = ["image1", "image2", "image3", "image4", "image5", "image6"]
        let likes = [10, 20, 30, 40, 50 ,60]
        let views = [100, 200, 300, 400, 500 ,600]

        for index in 0..<authors.count {
            let post = Post(author: authors[index], description: descriptions[index], image: images[index], likes: likes[index], views: views[index])
            posts.append(post)
        }

        return posts
    }
}
