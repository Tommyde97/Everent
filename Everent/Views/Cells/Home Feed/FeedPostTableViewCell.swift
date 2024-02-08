//
//  FeedPostTableViewCell.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/8/24.
//

import UIKit

class FeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        //Configure the Cell
    }
}
