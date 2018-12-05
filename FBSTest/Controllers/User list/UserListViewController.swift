//
//  UserListTableViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import RxSwift
import TableKit

final class UserListViewController: UIViewController, UserListView {

    var onLogout: (() -> Void)?
    var onUserSelect: ((UserViewModel) -> Void)?

    var viewModel: UserListViewModel!

    private let disposeBag = DisposeBag()

    private lazy var tableDirector: TableDirector = {
        TableDirector(tableView: self.tableView)
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.backgroundColor = .white
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        configureBarButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadUserList(reload: false)
        view.backgroundColor = .white
    }

    private func bindViews() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.loadUserList(reload: true)
            })
            .disposed(by: disposeBag)

        viewModel
            .userObservable
            .observeOn(MainScheduler.instance)
            // simulate network request delay
            .delay(1.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                if let user = $0 {
                    self?.insertTableHeaderView(user: user)
                }
            })
            .disposed(by: disposeBag)
    }

    private func configureBarButtons() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .done, target: nil, action: nil)
        logoutButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onLogout?()
            })
            .disposed(by: disposeBag)

        navigationItem.rightBarButtonItem = logoutButton
    }

}

extension UserListViewController {

    private func loadUserList(reload: Bool) {
        viewModel
            .loadCellViewModels(reload: reload)
            .observeOn(MainScheduler.instance)
            .share()
            .do(onNext: { [weak self] _ in
                self?.tableView.refreshControl?.endRefreshing()
            })
            .subscribe(onNext: { [weak self] in
                self?.configureTableView(cellViewModels: $0)
            })
            .disposed(by: disposeBag)
    }

    private func configureTableView(cellViewModels: [UserListCellViewModel]) {
        let rows = cellViewModels.map { TableRow<UserListCell>(item: $0)
            .on(.click) { [weak self] (options) in
                self?.onUserSelect?(options.item.userViewModel)
            } }

        tableDirector.clear()
        tableDirector += rows
        tableDirector.reload()
    }

    private func createTableHeaderView(user: User) -> UIView {
        let height: CGFloat = 70
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.width,
                                              height: height))

        let label = UILabel()
        label.text = user.nickname
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        let image = UIImage.User.avatarPlaceholder
        let avatarImageView = UIImageView(image: image)

        if let url = URL(string: user.avatarUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        avatarImageView.image = UIImage(data: data)
                    }
                }
            }
        }

        headerView.addSubview(avatarImageView)
        let avatarHeight: CGFloat = height - 20
        avatarImageView.layer.cornerRadius = avatarHeight / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -15).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: avatarHeight).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true

        return headerView
    }

    private func insertTableHeaderView(user: User) {
        let headerView = createTableHeaderView(user: user)
        tableView.beginUpdates()
        tableView.tableHeaderView = headerView
        tableView.endUpdates()
    }
}
