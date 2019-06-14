//
//  ViewController.swift
//  QuotePro
//
//  Created by Frank Chen on 2019-06-12.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,QuoteBuilderDelegate{
  
  var quotes = [NSManagedObject]()
  
  let tableView:UITableView = {
    let tb = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    tb.translatesAutoresizingMaskIntoConstraints = false
    tb.rowHeight = UITableView.automaticDimension
    tb.estimatedRowHeight = UITableView.automaticDimension
    tb.register(CustomCell.self, forCellReuseIdentifier: "customCell")
    return tb
  }()
  
  lazy var addButton : UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
      print("Documents Directory: \(documentsPath)")
    }
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Quotes")
    do{
      quotes = try context.fetch(fetchRequest)
      tableView.reloadData()
    }catch let error{
      print(error)
    }
  }
  
  func setupViews(){
    self.navigationItem.rightBarButtonItem = addButton
    self.navigationItem.title = "Home"
    self.view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      ])
  }
  
  @objc func addButtonTapped(){
    print("add tapped")
    let dvc = QuoteBuilderViewController()
    dvc.delegate = self
    self.navigationController?.pushViewController(dvc, animated: true)
  }


}

extension ViewController:UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let quote = quotes[indexPath.row]
    let photoData = quote.value(forKey: "imageData") as? Data
    guard let photo = photoData else{return}
    let image = UIImage(data: photo)
    guard let quoteImage = image else{return}
    
    print(quote)
    let quoteView = QuoteView()
    quoteView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    quoteView.imageView.image = quoteImage
    quoteView.nameLabel.text = quote.value(forKeyPath: "author") as? String
    quoteView.quoteLabel.text = quote.value(forKeyPath:"quote") as? String
    quoteView.layoutIfNeeded()
    let snapshot = quoteView.snapshot()
    let uav = UIActivityViewController(activityItems: [snapshot], applicationActivities: nil)
    self.present(uav, animated: true, completion: nil)
  }
}

extension ViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quotes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
    let quote = quotes[indexPath.row]
    cell.nameLabel.text = quote.value(forKeyPath: "author") as? String
    cell.quoteLabel.text = quote.value(forKeyPath: "quote") as? String
    return cell
  }
  
  func saveQuote(quote: Quote) {
    //self.quotes.append(quote)
    tableView.reloadData()
  }
  
}

extension UIView {
  func snapshot() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, self.isOpaque, UIScreen.main.scale)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
