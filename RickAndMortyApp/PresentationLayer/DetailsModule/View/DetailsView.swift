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
				AsyncImage(url: URL(string: character.image ?? "")) { phase in
					if let image = phase.image {
						image
							.resizable()
							.scaledToFit()
					} else if phase.error != nil {
						Text("There was an error loading image.")
					} else {
						ProgressView()
					}
				}
				.frame(width: 148, height: 148)
				.clipShape(RoundedRectangle(cornerRadius: 16))
				VStack (spacing: 8) {
					Text("\(character.name)")
						.font(Font.custom("Gilroy-ExtraBold", fixedSize: 22))
					Text("\(character.status)")
						.font(Font.custom("Gilroy-Light", size: 16))
						.foregroundColor(Color.greenFuxia)
				}
				.padding()
				InfoView(character: character)
				OriginView(character: character)
				EpisodesView(character: character)
			}
			.padding(.top, 100)
		}
		.ignoresSafeArea()
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
