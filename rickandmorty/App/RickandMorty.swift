//
//  rickandmorty.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import SwiftUI

struct RickAndMorty: App {
    var body: some Scene {
        WindowGroup {
            CharactersView(viewModel: CharactersViewModel())
        }
    }
}
