//
//  UserListTableViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import LeadKit
import RxSwift
import TableKit

final class UserListViewController: BaseConfigurableController<UserListViewModel>, UserListView {

    var onLogout: (() -> Void)?
    var onUserSelect: ((User) -> Void)?

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
        initialLoadView()
    }

    override func bindViews() {
        viewModel
            .userObservable
            .observeOn(MainScheduler.instance)
            // simulate network request delay
            .delay(1.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.insertTableHeaderView(user: $0)
            })
            .disposed(by: disposeBag)

        viewModel
            .userListObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.configureTableView(cellViewModels: $0)
            })
            .disposed(by: disposeBag)
    }

    override func configureBarButtons() {
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

    private func configureTableView(cellViewModels: [UserListCellViewModel]) {
        let rows = cellViewModels.map { TableRow<UserListCell>(item: $0)
            .on(.click) { [weak self] (options) in
                self?.onUserSelect?(options.item.user)
            } }
        tableDirector.append(rows: rows)
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

        let image = user.avatarImage
        let avatarImageView = UIImageView(image: image)
        headerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -15).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: (height - 10)/2).isActive = true
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
