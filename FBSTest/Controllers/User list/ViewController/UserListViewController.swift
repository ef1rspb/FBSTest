//
//  UserListTableViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import RxSwift

final class UserListViewController: UITableViewController, UserListView {

  // MARK: - Callbacks

  var onLogout: (() -> Void)?
  var onUserSelect: ((UserViewModel) -> Void)?

  // MARK: - Properties

  var viewModel: UserListViewModel!

  private let disposeBag = DisposeBag()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    bindTableView()
    loadHeaderView()
    setupNavigationButton()
  }

  // MARK: - Bind view

  private func bindTableView() {
    // Workaround for Rx
    tableView.delegate = nil
    tableView.dataSource = nil
    tableView.registerClassForCell(UserListCell.self)

    tableView.refreshControl = UIRefreshControl()
    Observable.merge(
        .just(()),
        tableView.refreshControl!.rx.controlEvent(.valueChanged).asObservable()
      )
      .flatMap { [unowned self] in self.viewModel.githubUsers }
      .map { $0.map { UserViewModel(user: $0) } }
      .observeOn(MainScheduler.instance)
      .do(onNext: { [unowned self] _ in
        self.refreshControl?.endRefreshing()
      })
      .bind(to: tableView.rx.items(cellIdentifier: UserListCell.reuseIdentifier,
                                   cellType: UserListCell.self)) { (_, userViewModel, cell) in
        cell.configure(with: userViewModel)
      }
      .disposed(by: disposeBag)

    tableView.rx
      .modelSelected(UserViewModel.self)
      .subscribe(onNext: { [unowned self] user in
        self.onUserSelect?(user)
      })
      .disposed(by: disposeBag)
  }

  // MARK: - Working with header view

  private func loadHeaderView() {
    viewModel
      .user
      .observeOn(MainScheduler.instance)
      // simulate network request delay
      .delay(1.5, scheduler: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] in
        if let user = $0 {
          self.setupHeaderView(user: user)
        }
      })
      .disposed(by: disposeBag)
    }

  private func setupHeaderView(user: User) {
    let headerView = UserListHeaderView()
    headerView.configure(with: user)

    tableView.beginUpdates()
    tableView.tableHeaderView = headerView
    tableView.tableHeaderView?.layoutIfNeeded()
    tableView.endUpdates()
  }

  private func setupNavigationButton() {
    let logoutButton = UIBarButtonItem(title: "Logout", style: .done, target: nil, action: nil)
    logoutButton.rx.tap
      .subscribe(onNext: { [unowned self] in
        self.onLogout?()
      })
      .disposed(by: disposeBag)

    navigationItem.rightBarButtonItem = logoutButton
  }
}
