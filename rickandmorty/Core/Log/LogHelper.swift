//
//  LogHelper.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

struct LogHelper {
  static func log(_ object: Any) {
  #if DEBUG
    print(object)
  #endif
  }
}

extension Error {
  func log() {
    #if DEBUG
    print(self)
    #endif
  }
}
