//
//  UserService.swift
//  Playtomic Architecture Assignment
//
//  Created by Angel Luis Garcia on 11/02/2020.
//  Copyright © 2020 Playtomic. All rights reserved.
//

import Foundation

class UserService {
    var count = 0
    func fetchCurrentUser(onComplete: @escaping (Result<User, UserError>) -> Void) {
        count += 1
        // Simulates asynchronous call
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.count % 3 == 0 {
                onComplete(Result.failure(UserError.connectivity))
            } else {
                let user = User(id: "1", name: "Jar Jar Binks", stars: Int.random(in: 100...1000))
                onComplete(Result.success(user))
            }
        }
    }

    func fetchUserFriends(userId: UserId, onComplete: @escaping (Result<[User], UserError>) -> Void) {
        // Simulates asynchronous call
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if userId == "1" {
                let users = [
                    User(id: "2", name: "Anakin Skywalker", stars: 1876),
                    User(id: "3", name: "Qui-Gon Jinn", stars: 987),
                    User(id: "4", name: "Padme Amidala", stars: 2917),
                    User(id: "5", name: "Obi-Wan Kenobi", stars: 1054)
                ]
                onComplete(Result.success(users))
            } else {
                onComplete(Result.failure(UserError.noFriends))
            }
        }
    }

    enum UserError: Error {
        case connectivity
        case noFriends
    }
}
