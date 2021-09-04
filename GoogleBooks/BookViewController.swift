//
//  BookViewController.swift
//  GoogleBooks
//
//  Created by Thejas K on 04/09/21.
//

import Foundation
import UIKit

class BookViewController : UIViewController {
    
    @IBOutlet weak var bookImageView: UIImageView?
    @IBOutlet weak var bookTitleLabel: UILabel?
    @IBOutlet weak var bookDescriptionView: UITextView?
    
    override func viewDidLoad() {
        
    }
    
    func updateBookInfo(bookInfo : BookInfo) {
        self.bookImageView?.image = bookInfo.image
        self.bookTitleLabel?.text = bookInfo.title
        self.bookDescriptionView?.text = bookInfo.description
        self.viewDidLoad()
    }
}
