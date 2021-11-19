//
//  DependencyManager.swift
//  Playtomic Architecture Assignment
//
//  Created by Jorge Andrade on 19/11/2021.
//  Copyright © 2021 Playtomic. All rights reserved.
//

import Foundation
import Resolver

struct DependencyManager {
    static func setupDependencies() {
        Resolver.register { UserListViewModel() }
    }
}
