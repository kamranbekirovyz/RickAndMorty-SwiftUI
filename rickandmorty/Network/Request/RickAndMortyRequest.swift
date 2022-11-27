//
//  GithubRequest.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

struct RickAndMortyRequest {}

extension RickAndMortyRequest {
  struct Characters: Request {
    var method: HTTPMethod { return .GET }
    var additionalHeaders: [String : String] = [:]
    var path: String { return "character" }
    var isQuery: Bool { return true }
  }
}
