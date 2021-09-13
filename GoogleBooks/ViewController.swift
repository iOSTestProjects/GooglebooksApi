//
//  ViewController.swift
//  GoogleBooks
//
//  Created by Thejas K on 03/09/21.
//
import Foundation
import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var bookTableView: UITableView!
    
    let itemsPerPage: Int64 = 10
    var currentPage: Int64 = 1
    var numberOfPages: Int64 = 1
    var totalBooks: Int64 = 0
    var currentItem : Int = 0
    
    let cellIdentifier = "cellIdentifier"
    var bookInfo : [BookInfo] = []
    var bookIn : BookInfo?
    var book : Library?
    var books : Array<Library?> = []
    var smallImage = UIImage()
    var largeImage = UIImage()
    
    var arrayImages : Array<UIImage> = []
    var arrayTitles : Array<String> = []
    var arrayDescription : Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookTableView.delegate = self
        self.bookTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callAPI(startFrom: 0)
        self.bookTableView.reloadData()
        print("Titles array item count : \(arrayTitles.count)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scrollViewDidScrollToTop(self.bookTableView)
        self.bookTableView.reloadData()
//        for book in BookSet.bookInfo! {
//            print("Book title populated : \(book.title)")
//        }
    }

    func callAPI(startFrom : Int64){
        let baseUrl = URL(string:"https://www.googleapis.com/books/v1/volumes?q=flowers&startIndex=\(startFrom)&maxResults=\(itemsPerPage)")!
        let task = URLSession.shared.dataTask(with: baseUrl) { jsonData, response, error in
                
            if(error != nil && jsonData == nil) {
                print("Error loading the data : \(String(describing: error?.localizedDescription))")
            } else {
                do
                {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let booksData = try decoder.decode(BooksApiResponse.self, from: jsonData!)
                    self.totalBooks = booksData.totalItems
                    print(">>>>>>totalBooks>>>>>>> \(self.totalBooks)")
                    self.numberOfPages = booksData.totalItems / self.itemsPerPage
                    print(">>>>>>numberOfPages>>>>>>> \(self.numberOfPages)")
                    self.loadUI(books: booksData)
                } catch {
                    print("Error loading JSON : \(error)")
                }
            }
            
            }
        task.resume()
    }
    
    // MARK : UI Udate and response methods
    func loadUI(books: BooksApiResponse) {
        // itemsPerPage
        // currentPage
        // numberOfPages
        // totalBooks
        // currentItem

        if(currentPage != 0) {
            
            let one = books.items[0].volumeInfo
            let two = books.items[1].volumeInfo
            let three = books.items[2].volumeInfo
            let four = books.items[3].volumeInfo
            let five = books.items[4].volumeInfo
            let six = books.items[5].volumeInfo
            let seven = books.items[6].volumeInfo
            let eight = books.items[7].volumeInfo
            let nine = books.items[8].volumeInfo
            let ten = books.items[9].volumeInfo
            
            self.populateCellData(volume: one)
            self.populateCellData(volume: two)
            self.populateCellData(volume: three)
            self.populateCellData(volume: four)
            self.populateCellData(volume: five)
            self.populateCellData(volume: six)
            self.populateCellData(volume: seven)
            self.populateCellData(volume: eight)
            self.populateCellData(volume: nine)
            self.populateCellData(volume: ten)
            
            for book in self.books {
                print("Book Title populated : \(String(describing: book?.bookTitle))")
            }
            
            let imageUrl = books.items[currentItem].volumeInfo.imageLinks.smallThumbnail
            
            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: URL(string: imageUrl)!) {
                    [weak self]
                    imageData, response, errr in
                    if(errr != nil)  {
                        debugPrint("Error loading image : \(errr!.localizedDescription)")
                    } else {
                        let image = UIImage(data: imageData!)
                        let largeImage = try? UIImage(data: Data(contentsOf: URL(string: books.items[self!.currentItem].volumeInfo.imageLinks.thumbnail)!))
                        let title = books.items[self!.currentItem].volumeInfo.title
                        let description = books.items[self!.currentItem].volumeInfo.description
                        self?.bookIn = BookInfo(smallImage: image!, largeImage: largeImage!, title: title, description: description)
                        
                    }
                }
                task.resume()
            }
        }
        
//        DispatchQueue.global().async {
//            let task = URLSession.shared.dataTask(with: URL(string: imageUrl)!) { imageData, response, errr in
//                if(errr != nil)  {
//                    debugPrint("Error loading image : \(errr!.localizedDescription)")
//                } else {
//                    let image = UIImage(data: imageData!)
//                    let largeImage = try? UIImage(data: Data(contentsOf: URL(string: books.items[9].volumeInfo.imageLinks.thumbnail)!))
//                    let title = bukin[0].volumeInfo.title
//                    let description = bukin[0].volumeInfo.description
//                    self.bookIn = BookInfo(smallImage: image!, largeImage: largeImage!, title: title, description: description)
//                    BookInfo.book = BookInfo(smallImage: image!, largeImage: largeImage!, title: title, description: description)
//                }
//            }
//            task.resume()
//        }
    }
    
    func populateCellData(volume : VolumeInfo) {
        
        DispatchQueue.main.async {
            let task1 = URLSession.shared.dataTask(with: URL(string: volume.imageLinks.smallThumbnail)!) {
                [weak self]
                imageData, _, error in
                if(error != nil && imageData == nil) {
                    debugPrint("Error loading images from given url : \(String(describing: error!.localizedDescription))")
                    if(imageData == nil) {
                        print("Image data is nil")
                    }
                } else {
                    if(self?.smallImage == nil){
                        self!.smallImage = UIImage()
                    }
                    
                    var image = UIImage()
                    image = UIImage(data: imageData!)!
                    self!.arrayImages.append(image)
                    self?.smallImage = UIImage(data: imageData!)!
                    self?.bookIn?.smallImage = self?.smallImage
                    print(self?.smallImage as Any)
                }
            }
            
            let task2 = URLSession.shared.dataTask(with: URL(string: volume.imageLinks.thumbnail)!) {
                [weak self]
                imageData, _, error in
                if(error != nil && imageData == nil) {
                    debugPrint("Error loading images from given url : \(error!.localizedDescription)")
                    if(imageData == nil) {
                        print("Image data is nil")
                    }
                } else {
                    if(self?.largeImage == nil){
                        self!.largeImage = UIImage()
                    }
                    
//                    var image = UIImage()
//                    image = UIImage(data: imageData!)!
//                    self!.arrayImages.append(image)
                    self?.largeImage = UIImage(data: imageData!)!
                    self?.bookIn?.largeImage = self?.largeImage
                }
            }
            
            task1.resume()
            task2.resume()
        }
        
        arrayTitles.append(volume.title)
        arrayDescription.append(volume.description)
        self.bookIn?.title = volume.title
        self.bookIn?.description = volume.description
        
        self.book = Library(smallImage: self.smallImage, largeImage: self.largeImage, bookTitle: volume.title, description: volume.description)
        self.books.append(book!)
    }
    
    func loadNextBooks(){
        let loadIndex = (currentPage * itemsPerPage) + itemsPerPage
        if (loadIndex < totalBooks){
            self.callAPI(startFrom: loadIndex)
        }
    }
    
    func loadPreviousBooks(){
        let loadIndex = (currentPage * itemsPerPage) - itemsPerPage
        if (loadIndex > 0){
            self.callAPI(startFrom: loadIndex)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK : Table view delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row > arrayTitles.count-1) {
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
            cell.cellImageView.contentMode = .scaleAspectFill
            
            let index = indexPath.row
            if(index >= 0 && index < 10) {
                cell.cellImageView.image = self.arrayImages[index]
                cell.cellTitleLabel.text = self.arrayTitles[index]
                cell.bookDescriptionLabel.text = self.arrayDescription[index]
            } else {
                print("print error")
            }
            return cell
        }
    }
    
    func getBookData(ofIndex : Int) -> BookInfo? {
        
        var book : BookInfo?
        
        bookInfo.forEach { ivar in
            book = BookInfo(smallImage: bookIn!.smallImage!, largeImage: bookIn!.largeImage!, title: bookIn!.title, description: bookIn!.description)
        }
        
        return book
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows : \(self.itemsPerPage)")
        return 10
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        // Refresh data
        // self.bookTableView.reloadData()
    }
}

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
