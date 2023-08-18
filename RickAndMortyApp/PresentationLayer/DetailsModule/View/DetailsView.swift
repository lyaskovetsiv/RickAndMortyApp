//
//  DetailsView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import SwiftUI

struct DetailsView: View {
	// MARK: - States&Properties

	private var character: Character

	// MARK: - Init

	init(character: Character) {
		self.character = character
	}

	// MARK: - UI

	var body: some View {
		ZStack {
			Color.backgroundColor
			VStack {
				HeaderView(character: character)
				InfoView(character: character)
				OriginView(character: character)
				EpisodesView(character: character)
			}
			.padding(.top, 100)
		}
		.ignoresSafeArea()
		.navigationBarBackButtonHidden(true)
		.navigationBarItems(leading: NavigationBackCustomButton())
	}
}

// MARK: - Preview

struct DetailsView_Previews: PreviewProvider {
	static var character = Character(name: "Rick Sanchez", status: "Alive",
									 species: "Human", type: "None", gender: "Male",
									 origin: Origin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"))
	static var previews: some View {
		DetailsView(character: character)
	}
}
