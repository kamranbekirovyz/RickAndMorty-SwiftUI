//
//  HomeUIModel.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

struct CharacterUIModel: Identifiable {
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
  
  struct Origin {
    let name: String
    let url: String
  }
  
  struct Location {
    let name: String
    let url: String
  }
}

extension CharacterUIModel {
  init(with character: RickAndMortyResponse.Character) {
    self.id = character.id
    self.name = character.name
    self.status = character.status
    self.species = character.species
    self.type = character.type
    self.gender = character.gender
    self.origin = Origin(name: character.origin.name, url: character.origin.url)
    self.location = Location(name: character.location.name, url: character.location.url)
    self.image = character.image
    self.episode = character.episode
    self.url = character.url
    self.created = character.created
  }
}

extension CharacterUIModel {
  static func mock() -> CharacterUIModel {
    return CharacterUIModel(
      id: 1,
      name: "name",
      status: "status",
      species: "species",
      type: "type",
      gender: "gender",
      origin: Origin(name: "name", url: "url"),
      location: Location(name: "name", url: "url"),
      image: "image",
      episode: [],
      url: "url",
      created: "created"
    )
  }
}
