//
//  UserListViewModel.swift
//  Playtomic Architecture Assignment
//
//  Created by Jorge Andrade on 19/11/2021.
//  Copyright © 2021 Playtomic. All rights reserved.
//

import Foundation
import RxRelay

class UserListViewModel {
    private let userService = UserService()
    private var user: User?
    private var friends = [User]()
    private var filteredFriends = [User]()
    
    var state = BehaviorRelay<State>(value: .initial)
    
    func load(query: String = "") {
        state.accept(.loading)
        guard let user = self.user, !query.isEmpty else {
            loadUser()
            return
        }
        
        loadFriends(user: user, query: query)
    }
    
    
    private func loadUser() {
        userService.fetchCurrentUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                self.loadFriends(user: user)
            case .failure:
                self.state.accept(.error)
            }
        }
    }

    private func loadFriends(user: User, query: String = "") {
        
        
        userService.fetchUserFriends(userId: user.id) { [weak self] result in
            guard let self = self else { return }
           
            switch result {
            case .success(let users):
                self.friends = users
                self.filteredFriends = self.friends.filter { query.isEmpty == true || $0.name.uppercased().contains(query.uppercased()) }
                self.state.accept(.loaded(user: user, friends: self.filteredFriends))
            case .failure:
                self.state.accept(.error)
            }
        }
    }
}

//MARK: Model
extension UserListViewModel {
    enum State {
        case initial
        case loading
        case loaded(user: User, friends: [User])
        case error
    }
}
