//
//  CharacterDetails.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import SwiftUI
import Combine

struct CharacterDetailsView: View {
  typealias Item = CharacterUIModel
  
  @ObservedObject private var viewModel: CharactersDetailsViewModel
  public let item: Item
  
  init(
    item: Item,
    viewmodel: CharactersDetailsViewModel = CharactersDetailsViewModel()
  ) {
    self.item = item
    self.viewModel = viewmodel
  }
  
  var body: some View {
    NavigationView {
      VStack {
        AsyncImage(url: URL(string: item.image))
          .clipShape(Circle())
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationBarTitle(item.name)
    }
  }
}

struct CharacterDetails_Previews: PreviewProvider {
  static var previews: some View {
    CharacterDetailsView(item: CharacterUIModel.mock())
  }
}
