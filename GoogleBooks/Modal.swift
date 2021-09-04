//
//  Modal.swift
//  GoogleBooks
//
//  Created by Thejas K on 03/09/21.
//

import Foundation
import UIKit

struct Books : Decodable {
    var totalItems : Int64
    var items :  [Book]
}

struct Book : Decodable {
    var id : String
    var selfLink : String
    var volumeInfo : VolumeInfo
}

struct VolumeInfo : Decodable {
    let imageLinks : Thumbnails
    let title : String
    let description : String
}

struct Thumbnails : Decodable {
    let smallThumbnail : String
    let thumbnail : String
}

class BookInfo {
    var image : UIImage
    var title : String
    var description : String
    
    init(image : UIImage , title : String , description : String) {
        self.image = image
        self.title = title
        self.description = description
    }
}
