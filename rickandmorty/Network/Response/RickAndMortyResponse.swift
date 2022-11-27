//
//  GithubResponse.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

struct RickAndMortyResponse {}

extension RickAndMortyResponse {
  struct Characters: Decodable {
    let info: Info
    let results: [Character]
    
    init(
      info: Info,
      results: [Character]
    ) {
      self.info = info
      self.results = results
    }
  }
  
  struct Info: Decodable {
    let count: Int
    let pages: Int
  }
  
  struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
  }
  
  struct Origin: Decodable {
    let name: String
    let url: String
  }
  
  struct Location: Decodable {
    let name: String
    let url: String
  }
}
