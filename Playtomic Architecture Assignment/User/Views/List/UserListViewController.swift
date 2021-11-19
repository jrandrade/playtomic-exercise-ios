//
//  UserListViewController.swift
//  Playtomic Architecture Assignment
//
//  Created by Angel Luis Garcia on 11/02/2020.
//  Copyright © 2020 Playtomic. All rights reserved.
//

import UIKit
import Resolver
import RxSwift

class UserListViewController: UIViewController {
    
    
    var viewModel: UserListViewModel = Resolver.resolve()
    var friends = [User]()
    var disposeBag = DisposeBag()
    
//MARK: - Views -
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        bind()
        viewModel.load()
    }
    @IBAction func reload() {
        viewModel.load()
    }
    

}
//MARK: - UITableViewDelegate -
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as? UserDetailViewController else {
            return
            
        }
        vc.user = friends[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource -
extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell")!
        let user = friends[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "\(user.stars) ⭐️"
        return cell
    }
}

//MARK: - UISearchBarDelegate -
extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.load(query: searchText)
    }
}

//MARK: - Private Functions -
extension UserListViewController {
    private func showError() {
        let alert = UIAlertController(title: nil, message: "There was an error loading", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func bind() {
        viewModel.state.subscribe {[weak self]  state in
            
            guard let self = self else { return }
            
            self.loadingView.isHidden = true
            
            switch state.element {
            case .loading:
                self.loadingView.isHidden = false
            case .error:
                self.showError()
            case .loaded(let user, let friends):
                self.title = "\(user.name) (\(user.stars))"
                self.friends = friends
                self.tableView.reloadData()
                
            default:
                break
            }
        }
        .disposed(by: disposeBag)
    }
}
