//
//  Modal.swift
//  GoogleBooks
//
//  Created by Thejas K on 03/09/21.
//

import Foundation
import UIKit

struct BooksApiResponse : Decodable {
    var totalItems : Int64
    var items :  [Book]
}

struct Book : Decodable {
    var id : String
    var selfLink : String
    var volumeInfo : VolumeInfo
}

struct VolumeInfo : Decodable {
    let title : String
    let description : String
    let imageLinks : Thumbnails
}

struct Thumbnails : Decodable {
    let smallThumbnail : String
    let thumbnail : String
}

struct Library {
    var smallImage : UIImage
    var largeImage : UIImage
    var bookTitle  : String
    var description : String
    
    init(smallImage : UIImage , largeImage : UIImage , bookTitle : String , description : String ) {
        self.smallImage = smallImage
        self.largeImage = largeImage
        self.bookTitle = bookTitle
        self.description = description
    }
}

public struct BookStack {
    var books = [Library]()
    
    init(book : Library) {
        self.books.append(book)
    }
}

// MARK : - Our Actual book data models derived from the above. 
public class BookInfo {
    
    var smallImage : UIImage?
    var largeImage : UIImage?
    var title : String
    var description : String
    
    init(smallImage : UIImage , largeImage : UIImage , title : String , description : String) {
        if(self.smallImage != nil) {
            self.smallImage = smallImage
        } else {
            self.smallImage = UIImage()
            self.smallImage = smallImage
        }
        
        if(self.largeImage != nil) {
            self.largeImage = largeImage
        } else {
            self.largeImage = UIImage()
            self.largeImage = largeImage
        }
        self.title = title
        self.description = description
    }
}

public class BookSet {
    static var books : [VolumeInfo] = []
    static var bookRack : [BookInfo]?
    static var bookShelve : [Library]?
}

//extension Array {
//    func getElement(at index: Int) -> Element? {
//        let isValidIndex = index >= 0 && index < count
//        return isValidIndex ? self[index] : nil
//    }
//}
