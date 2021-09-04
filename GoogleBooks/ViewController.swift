//
//  ViewController.swift
//  GoogleBooks
//
//  Created by Thejas K on 03/09/21.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var bookTableView: UITableView!
    
    let itemsPerPage: Int64 = 10;
    var currentPage: Int64 = 1;
    var numberOfPages: Int64 = 1;
    var totalBooks: Int64 = 0;
    
    let cellIdentifier = "cellIdentifier"
    var bookInfo : [BookInfo] = []
    var bookIn : BookInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookTableView.delegate = self
        self.bookTableView.dataSource = self
        self.callAPI(startFrom: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scrollViewDidScrollToTop(self.bookTableView)
        self.bookTableView.reloadData()
    }

    func callAPI(startFrom : Int64){
        let url = URL(string:"https://www.googleapis.com/books/v1/volumes?q=flowers&startIndex=\(startFrom)&maxResults=\(itemsPerPage)")!
        let task = URLSession.shared.dataTask(with: url) { jsonData, response, error in
                do
                {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let booksData = try decoder.decode(Books.self, from: jsonData!)
                    self.totalBooks = booksData.totalItems
                    print(">>>>>>totalBooks>>>>>>> \(self.totalBooks)")
                    self.numberOfPages = booksData.totalItems / self.itemsPerPage
                    print(">>>>>>numberOfPages>>>>>>> \(self.numberOfPages)")
                    
                    DispatchQueue.main.async {
                        self.loadUI(books: booksData.items)
                    }
                }
                catch
                {
                    print("Error loading JSON : \(error.localizedDescription)")
                }
            }
        task.resume()
    }
    
    
    // MARK : Table view delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomCell
        cell.cellImageView.image = bookIn?.image
        cell.cellTitleLabel.text = bookIn?.title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows : \(self.itemsPerPage)")
        return Int(self.itemsPerPage)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        // Refresh data
        self.bookTableView.reloadData()
    }
    
    // MARK : UI Udate and response methods
    func loadUI(books: [Book]) {
        // itemsPerPage
        // currentPage
        // numberOfPages
        // totalBooks
        // current page items : books
        let bookInfo = books[2]
        let imageUrl = bookInfo.volumeInfo.imageLinks.smallThumbnail
        
//        DispatchQueue.main.async {
//            let task = URLSession.shared.dataTask(with: URL(string: imageUrl)!) { imageData, response, errr in
//                if(errr != nil)  {
//                    debugPrint("Error loading image : \(errr!.localizedDescription)")
//                } else {
//                    let image = UIImage(data: imageData!)
//                    let title = bookInfo.volumeInfo.title
//                    let description = bookInfo.volumeInfo.description
//                    self.bookIn = BookInfo(image: image!, title: title, description: description)
//                }
//            }
//            task.resume()
//        }
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: URL(string: imageUrl)!) { imageData, response, errr in
                if(errr != nil)  {
                    debugPrint("Error loading image : \(errr!.localizedDescription)")
                } else {
                    let image = UIImage(data: imageData!)
                    let title = bookInfo.volumeInfo.title
                    let description = bookInfo.volumeInfo.description
                    self.bookIn = BookInfo(image: image!, title: title, description: description)
                }
            }
            task.resume()
        }
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
        if segue.identifier == "detailBookViewSegue" {
            let vc = BookViewController()
            vc.updateBookInfo(bookInfo: bookIn!)
        }
    }
}
