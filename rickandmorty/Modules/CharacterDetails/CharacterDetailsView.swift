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
      List() {
        VStack(){
          VStack(alignment: .leading) {
            AsyncImage(url: URL(string: item.image)) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
          } placeholder: {
            ProgressView()
          }
              .frame(width: 64, height: 64)
              .scaledToFit()
              .clipShape(Circle())
              .padding(24)
            
            buildProperty(label: "Species", description: item.species)
            buildProperty(label: "Gender", description: item.gender)
            buildProperty(label: "Status", description: item.status)
            buildProperty(label: "Type", description: item.type)
            buildProperty(label: "Episodes", description: item.episode.first ?? "unknown")
            buildProperty(label: "Location", description: item.location.name)
            buildProperty(label: "Origin", description: item.origin.name)
            buildProperty(label: "Created", description: item.created)
            
          }
          
        }
      }
      .listStyle(.insetGrouped)
    }
  }
  
  private func buildProperty(
    label: String,
    description: String
  ) -> some View {
    HStack() {
      
      Text(label).font(.headline)
      Spacer(minLength: .ulpOfOne)
      Text(description).font(.subheadline)
    }
    .padding(2)
  
  }
}

struct CharacterDetails_Previews: PreviewProvider {
  static var previews: some View {
    CharacterDetailsView(item: CharacterUIModel.mock())
  }
}
