//
//  CustomCell.swift
//  QuotePro
//
//  Created by Frank Chen on 2019-06-12.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
  
  let nameLabel : UILabel = {
    let label = UILabel()
    label.textColor = .red
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let quoteLabel : UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(nameLabel)
    self.addSubview(quoteLabel)
    
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
      nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),
      
      quoteLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4),
      quoteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
      quoteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
      quoteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
      quoteLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 14),
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
