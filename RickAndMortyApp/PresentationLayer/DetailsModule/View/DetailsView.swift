//
//  DetailsView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import SwiftUI

struct DetailsView: View {

	// MARK: - States&Properties

	@State private var character: Character

	// MARK: - Init

	init(character: Character) {
		self.character = character
	}

	// MARK: - UI
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

// MARK: - Preview

struct DetailsView_Previews: PreviewProvider {
	static var previews: some View {
		DetailsView(character: Character(name: "Ivan"))
	}
}
