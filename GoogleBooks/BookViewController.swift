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
    
    var book : BookInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookImageView?.contentMode = .scaleToFill
        self.bookImageView?.backgroundColor = .purple
        
        if(self.book != nil) {
            self.bookImageView?.image = self.book?.image
            self.bookTitleLabel?.text = self.book?.title
            self.bookDescriptionView?.text = self.book?.description
        } else {
            print("Wait for the function to load data first. Then launch view did load inside that function")
        }
    }
    
    func updateBookInfo(bookInfo : BookInfo) {
        
        self.book = BookInfo(image: bookInfo.image, title: bookInfo.title, description: bookInfo.description)
        
        if(self.book == nil) {
            print("Instance not initialised properly")
        } else {
            print("Instance initialised properly. If problem persists then check how to pass data among view controllers")
            self.viewDidLoad()
        }
    }
}
