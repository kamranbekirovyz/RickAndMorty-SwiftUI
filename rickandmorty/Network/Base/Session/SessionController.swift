//
//  SessionController.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation
import Combine

protocol SessionControllerType {
  var token: String { get }
  var api: API { get }
}

final class SessionController: SessionControllerType {
  
  var api: API
  
  init(_ api: API = RickAndMortyAPI()) {
    self.api = api
  }
}

extension SessionController {
  var token: String {
    return ""
  }
}
