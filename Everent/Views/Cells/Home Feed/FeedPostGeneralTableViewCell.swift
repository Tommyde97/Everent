//
//  FeedPostGeneralTableViewCell.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/8/24.
//

import UIKit

/// Comments
class FeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier  = "FeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondaryLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        //Configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

