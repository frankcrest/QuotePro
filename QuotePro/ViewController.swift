//
//  ViewController.swift
//  QuotePro
//
//  Created by Frank Chen on 2019-06-12.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController,QuoteBuilderDelegate{
  
  var quotes = [Quote]()
  
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
    setupViews()
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
    let items = ["test"]
    let uav = UIActivityViewController(activityItems: items, applicationActivities: nil)
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
    cell.nameLabel.text = quote.quoteAuthor
    cell.quoteLabel.text = quote.quoteText
    return cell
  }
  
  func saveQuote(quote: Quote) {
    self.quotes.append(quote)
    tableView.reloadData()
  }
  
}
