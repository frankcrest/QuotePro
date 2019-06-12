//
//  Quote.swift
//  QuotePro
//
//  Created by Frank Chen on 2019-06-12.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import Foundation

struct Quote:Decodable{
  var quoteAuthor:String
  var quoteText:String
  var photo:Data?
}
