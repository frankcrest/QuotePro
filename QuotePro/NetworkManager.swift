//
//  NetworkManager.swift
//  QuotePro
//
//  Created by Frank Chen on 2019-06-12.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager{
  
  let quoteApi = "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json"
  
  func getQuote(completion:@escaping (_ quote:Quote)->Void)
  {
    let url = URL(string: quoteApi)!
    
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
      if let error = error{
        print(error)
        return
      }
      
      guard let data = data else { return }
      
      let decoder = JSONDecoder()
      
      let quoteObject = try? decoder.decode(Quote.self, from: data)
      guard let quote = quoteObject else{ print("couldnt decode quote\(data))"); return}
      completion(quote)
    }
    task.resume()
  }
  
  func getImage(width:CGFloat,height:CGFloat,completion:@escaping (_ photo:Photo)->Void)
  {
    print(width)
    print(height)
    let url = URL(string: "http://lorempixel.com/\(Int(width))/\(Int(height))")!
    
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
      if let error = error{
        print(error)
        return
      }
      
      guard let data = data else { return }
      let photo = Photo(image:data)
      completion(photo)
    }
    task.resume()
  }
}
