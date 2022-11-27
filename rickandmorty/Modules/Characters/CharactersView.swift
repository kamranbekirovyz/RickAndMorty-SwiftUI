//
//  RepositoryView.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import SwiftUI
import Combine

struct CharactersView: View {
  @ObservedObject private var viewModel: CharactersViewModel
  
  init(viewModel: CharactersViewModel) {
    self.viewModel = viewModel
    self.viewModel.getCharacters()
  }
  
  var body: some View {
    NavigationView {
      VStack {
        mainView()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationBarTitle("Characters")
    }
  }
  
  private func mainView() -> some View {
    VStack {
      List(viewModel.characters, id: \.id) { character in
        NavigationLink(destination: {
          CharacterDetailsView(item: character)
        }, label: {
          CharactersView.CharacterCell(item: character)
        })
      }
      .listStyle(.insetGrouped)
      .onAppear {
        UITableView.appearance().tableFooterView = UIView()
      }
      .refreshable {
        viewModel.refresh()
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    CharactersView(viewModel: CharactersViewModel())
  }
}
