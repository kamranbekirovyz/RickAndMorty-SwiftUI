//
//  Repository+Cell.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import SwiftUI

extension CharactersView {
  struct CharacterCell: View {
    typealias Item = CharacterUIModel
    @Namespace var heroAnimation: Namespace.ID
    
    private let item: Item
    
    init(item: Item) {
      self.item = item
    }
    
    var body: some View {
      HStack {
        AsyncImage(url: URL(string: item.image)) { image in
                    image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                } placeholder: {
                  ProgressView()
                }
        
        .frame(width: 64, height: 64)
        .clipShape(Circle())
        
        Spacer().frame(width: 16.0)
        
        VStack(alignment: .leading, spacing: 8.0) {
          Text(item.name)
            .font(.headline)
            .foregroundColor(Color("Black"))
          
          Text("\(item.gender), \(item.species) (\(item.status))")
            .font(.subheadline)
            .foregroundColor(Color("Black"))
            .lineLimit(5)
        }
      }
    }
  }
}
