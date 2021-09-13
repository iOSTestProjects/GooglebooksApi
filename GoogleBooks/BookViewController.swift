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
    @IBOutlet weak var bookDescription: UITextView?
    
    var book : BookInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookImageView?.contentMode = .scaleAspectFill
        self.bookImageView?.backgroundColor = .purple
        
        self.recieveInformation()
        
        if(self.book != nil) {
            print("Working")
        } else {
            print("Book info object contains data and not nil")
        }
    }
    
    func recieveInformation() {
        
        self.bookImageView?.image = BookSet.bookRack?[0].largeImage
        self.bookTitleLabel?.text = BookSet.bookRack?[0].title
        self.bookDescription?.text = BookSet.bookRack?[0].description
    }
}
