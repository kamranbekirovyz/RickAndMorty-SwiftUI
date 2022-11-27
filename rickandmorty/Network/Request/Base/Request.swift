//
//  Request.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

public enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
  case PATCH
}

public protocol Request {
  var method: HTTPMethod { get }
  var path: String { get }
  var additionalHeaders: [String: String] { get }
  var isQuery: Bool { get }
}

extension Request {
  var method: HTTPMethod { return .GET }
  var isQuery: Bool { return true }
}
