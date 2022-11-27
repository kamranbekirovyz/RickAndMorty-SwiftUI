//
//  RepositoryInteractor.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation
import Combine

protocol CharactersInteractorType: AnyObject {
  func getCharacters(params: [Network.Parameter]?) -> AnyPublisher<CharactersInteractor.CharactersPartialState, Never>
}

final class CharactersInteractor: CharactersInteractorType {
  
  private let rickAndMortyService = RickAndMortyService()
  private lazy var sessionController = SessionController()
  
  private var cancellabes = Set<AnyCancellable>()
  
  func getCharacters(params: [Network.Parameter]? = nil) -> AnyPublisher<CharactersPartialState, Never> {
    return Deferred {
      Future { [weak self] promise in
        guard let self = self else { return }
        
        self.rickAndMortyService.getCharacters(params)
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
              promise(.success(.failure(error)))
            case .finished: break
            }
          }, receiveValue: { response in
            guard let response = response else {
              promise(.success(.failure(NetworkError(message: "No content found!"))))
              return
            }
            
            promise(.success(.success(response.info, response.results)))
            return
          })
          .store(in: &self.cancellabes)
      }
    }.eraseToAnyPublisher()
  }
}

extension CharactersInteractor {
  enum CharactersPartialState {
    case success(RickAndMortyResponse.Info, [RickAndMortyResponse.Character])
    case failure(Error)
  }
}
