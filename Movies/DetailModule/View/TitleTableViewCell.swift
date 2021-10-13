// TitleTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit
/// Title label
class TitleTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!

    func addTitle(title: String?) {
        titleLabel.text = title
    }
}
