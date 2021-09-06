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
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    
    func updateBookInfoInDetailView(bookInfo : BookInfo) {
        let vc = BookViewController()
        vc.bookImageView?.image = bookInfo.image
        vc.bookTitleLabel?.text = bookInfo.title
        vc.bookDescriptionView?.text = bookInfo.description
    }
    
    func setCellWith(bookInfo : BookInfo) {
        cellImageView.image = bookInfo.image
        cellTitleLabel.text = bookInfo.title
        bookDescriptionLabel.text = bookInfo.description
    }
}
