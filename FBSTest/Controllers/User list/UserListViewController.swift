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
        table.tableHeaderView = tableHeaderView
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.backgroundColor = .white
        return table
    }()

    private lazy var tableHeaderView: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
        header.backgroundColor = .red
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadView()
    }

    override func bindViews() {
        viewModel
            .userListObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.configureTableView(cellViewModels: $0)
            })
            .disposed(by: disposeBag)
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
}
