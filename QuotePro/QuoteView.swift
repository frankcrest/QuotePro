//
//  QuoteView.swift
//  QuotePro
//
//  Created by Frank Chen on 2019-06-12.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit

class QuoteView: UIView {
  
  let imageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()
  
  let nameLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 25)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let quoteLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(imageView)
    self.addSubview(nameLabel)
    self.addSubview(quoteLabel)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
      imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
      
      nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
      nameLabel.heightAnchor.constraint(equalToConstant: 25),
      
      quoteLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 240),
      quoteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      quoteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      quoteLabel.heightAnchor.constraint(equalToConstant: 140)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupQuote(quote:Quote){
    nameLabel.text = quote.quoteAuthor
    quoteLabel.text = quote.quoteText
  }
  
  func setupPhoto(photo:Photo){
    print(photo)
    let image = UIImage(data: photo.image)
    imageView.image = image
  }
  
}
