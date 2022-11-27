//
//  RepositoryViewModel.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation
import Combine

final class CharactersViewModel: ObservableObject {
  
  private let interactor = CharactersInteractor()
  private var cancellabes = Set<AnyCancellable>()
  
  private var totalPageNumber = 0
  private var currentPageNumber = 0
  
  @Published var characters: [CharacterUIModel] = []
  @Published var error: Error?
  
  func getCharacters() {
    currentPageNumber += 1
    let params: [Network.Parameter] = [
      Network.Parameter(key: "page", value: "\(currentPageNumber)")
    ]
    
    interactor.getCharacters(params: params)
      .sink(receiveValue: { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let info, let chars):
          self.totalPageNumber = info.pages
          self.characters = chars.map { CharacterUIModel(with: $0) }
        case .failure(let error):
          self.error = error
        }
      }).store(in: &cancellabes)
  }
  
  func refresh() {
    self.totalPageNumber = 0
    self.currentPageNumber = 0
    
    self.getCharacters()
  }
}
