//
//  Parameter.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

extension Network {
  struct Parameter {
    let key: String
    let value: String
    
    init(key: String, value: String) {
      self.key = key
      self.value = value
    }
  }
}

