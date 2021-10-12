// DecsriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Description label
class DecsriptionTableViewCell: UITableViewCell {
    @IBOutlet private var descriptionLabel: UILabel!

    func addDescription(_ description: String?) {
        descriptionLabel.text = description
    }
}
