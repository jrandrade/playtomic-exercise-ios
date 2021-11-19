//
//  UserListViewController.swift
//  Playtomic Architecture Assignment
//
//  Created by Angel Luis Garcia on 11/02/2020.
//  Copyright © 2020 Playtomic. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private let userService = UserService()
    private var user: User?
    private var friends: [User]?
    private var filteredFriends: [User]?

    @IBOutlet weak var searchBar: UISearchBar!
    // FIXME: Replace this as appropiate for your architecture
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    // FIXME: Replace this as appropiate for your architecture
    @IBAction func reload() {
        loadingView.isHidden = false
        userService.fetchCurrentUser { [weak self] result in
            self?.loadingView.isHidden = true
            switch result {
            case .success(let user):
                self?.loadFriends(user: user)
            case .failure:
                self?.showError()
            }
        }
    }

    // FIXME: Replace this as appropiate for your architecture
    private func loadFriends(user: User) {
        loadingView.isHidden = false
        userService.fetchUserFriends(userId: user.id) { [weak self] result in
            self?.loadingView.isHidden = true
            switch result {
            case .success(let users):
                self?.updateView(user: user, friends: users)
            case .failure:
                self?.showError()
            }
        }
    }

    // FIXME: Replace this as appropiate for your architecture
    private func updateView(user: User, friends: [User]) {
        self.user = user
        self.friends = friends
        self.filteredFriends = friends.filter { searchBar.text?.isEmpty == true || $0.name.uppercased().contains(searchBar.text?.uppercased() ?? "") }
        self.title = "\(user.name) (\(user.stars))"
        self.tableView.reloadData()
    }

    private func showError() {
        let alert = UIAlertController(title: nil, message: "There was an error loading", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell")!
        let user = filteredFriends?[indexPath.row]
        cell.textLabel?.text = user?.name
        cell.detailTextLabel?.text = "\(user?.stars ?? 0) ⭐️"
        return cell
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let user = self.user, let friends = self.friends else { return }
        updateView(user: user, friends: friends)
    }
}
