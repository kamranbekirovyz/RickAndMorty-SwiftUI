//
//  Data+Extensions.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

public extension Data {
  var prettyJson: String? {
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]),
          let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
    
    return prettyPrintedString
  }
}
