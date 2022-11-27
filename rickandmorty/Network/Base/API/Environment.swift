//
//  Environment.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

protocol EnvironmentType {
  var baseHost: URL? { get }
}

struct Environment: EnvironmentType {
  var baseHost: URL? {
    URL(string: bundleValue(key: "Base Host"))
  }
  
  private func bundleValue(key: String) -> String {
    return Bundle.main.infoDictionary?[key] as? String ?? ""
  }
}
