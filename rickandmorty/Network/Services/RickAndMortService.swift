//
//  GithubService.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation
import Combine

protocol RickAndMortyServiceType: AnyObject {
  func getCharacters(_ parameters: [Network.Parameter]?) -> AnyPublisher<RickAndMortyResponse.Characters?, Error>
}

final class RickAndMortyService: NetworkService, RickAndMortyServiceType {
  func getCharacters(_ parameters: [Network.Parameter]?) -> AnyPublisher<RickAndMortyResponse.Characters?, Error> {
    let urlRequest = RickAndMortyRequest.Characters()
    return request(request: urlRequest, parameters: parameters)
  }
}
