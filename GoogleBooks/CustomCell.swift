//
//  CustomCell.swift
//  GoogleBooks
//
//  Created by Thejas K on 04/09/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    func setCellWith(bookInfo : BookInfo) {
        cellImageView.image = bookInfo.image
        cellTitleLabel.text = bookInfo.title
    }
}
