//
//  Playtomic_Architecture_Assignment_UnitTests.swift
//  Playtomic Architecture Assignment UnitTests
//
//  Created by Jorge Andrade on 19/11/2021.
//  Copyright © 2021 Playtomic. All rights reserved.
//

import XCTest
@testable import Playtomic_Architecture_Assignment
class Playtomic_Architecture_Assignment_UnitTests: XCTestCase {
    var sut = UserService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserService() throws {
        sut.fetchCurrentUser { result in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let user):
                XCTAssertEqual(user.name, "Jar Jar Binks")
            }
        }
    }

    func testFriendsService() throws {
        sut.fetchUserFriends(userId: "1") { result in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let friends):
                XCTAssertEqual(friends.first?.name, "Anakin Skywalker")
            }
        }
    }
}
