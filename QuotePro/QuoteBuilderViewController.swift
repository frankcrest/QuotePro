//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by Frank Chen on 2019-06-12.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit
import CoreData

protocol QuoteBuilderDelegate {
  //func saveQuote(quote:Quote)
}

class QuoteBuilderViewController: UIViewController {
  
  var delegate:QuoteBuilderDelegate?
  let netWorker = NetworkManager()
  var quote:Quote?
  var photo:Photo?
  
  lazy var saveButton : UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    return button
  }()
  
  lazy var leftSwipeGesture:UISwipeGestureRecognizer = {
    let gesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
    gesture.direction = .left
    return gesture
  }()
  
  lazy var rightSwipeGesture:UISwipeGestureRecognizer = {
    let gesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
    gesture.direction = .right
    return gesture
  }()
  
  let quoteView : QuoteView = {
    let view = QuoteView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.isUserInteractionEnabled = true
    setupViews()
  }
  
  func setupViews(){
    self.view.backgroundColor = .white
    self.navigationItem.rightBarButtonItem = saveButton
    self.view.addGestureRecognizer(leftSwipeGesture)
    self.view.addGestureRecognizer(rightSwipeGesture)
    
    self.view.addSubview(quoteView)
    
    NSLayoutConstraint.activate([
      quoteView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
      quoteView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      quoteView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      quoteView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
      ])
  }
  
  @objc func saveTapped(){
    print("save tapped")
    guard var newQuote = self.quote else{return}
    print(newQuote)
    guard let myPhoto = self.photo else{return}
    print(myPhoto)
    newQuote.photo = myPhoto.image
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Quotes", in: context)!
    let quote = NSManagedObject(entity: entity, insertInto: context)
    quote.setValue(newQuote.quoteAuthor, forKey: "author")
    quote.setValue(newQuote.quoteText, forKey: "quote")
    quote.setValue(newQuote.photo, forKey: "imageData")
    
    do {
      try context.save()
    }catch let error{
      print(error)
    }
    
    //delegate?.saveQuote(quote: newQuote)
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func leftSwiped(){
    print("left swipe")
    
    netWorker.getQuote { (quote) in
      self.quote = quote
      DispatchQueue.main.async{
        self.quoteView.setupQuote(quote: quote)
      }
    }
  }
  
  @objc func rightSwiped(){
    print("right swipe")
    let height = self.view.bounds.height
    let topAnchorHeight = self.view.safeAreaLayoutGuide.layoutFrame.minY
    netWorker.getImage(width: self.view.bounds.width, height: height - topAnchorHeight) { (photo) in
      self.photo = photo
      DispatchQueue.main.async {
        self.quoteView.setupPhoto(photo:photo)
      }
    }
  }
  
  
  
}
