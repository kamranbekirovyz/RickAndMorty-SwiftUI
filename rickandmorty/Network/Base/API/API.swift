//
//  API.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

typealias HTTPHeaders = [String: String]

protocol API {
  var enviroment: EnvironmentType { get }
  var headers: HTTPHeaders { get }
}

struct RickAndMortyAPI: API {
  let enviroment: EnvironmentType
  let headers: HTTPHeaders
  
  init() {
    self.enviroment = Environment()
    self.headers = [
      Header.CONTENT_TYPE.rawValue: "application/json"
    ]
  }
}
