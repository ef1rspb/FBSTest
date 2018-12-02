//
//  UserListCell.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import TableKit
import LeadKit

final class UserListCell: SeparatorCell {

    private let titleLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension UserListCell: ConfigurableCell {

    func configure(with viewModel: UserListCellViewModel) {
        titleLabel.text = viewModel.title
    }
}
