//
//  Network.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

public struct Network {}

struct NetworkError: Decodable, Equatable, LocalizedError {
  var code: Int?
  var message: String?
  
  public init(
    code: Int? = nil,
    message: String? = nil
  ) {
    self.code = code
    self.message = message
  }
  
  public var errorDescription: String? {
    if let message = message, !message.isEmpty {
      return message
    }
    
    if let message = message, !message.isEmpty {
      return message
    }
    
    return nil
  }
}
