// TitleTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class TitleTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!

    func addTitle(title: String?) {
        titleLabel.text = title
    }
}
