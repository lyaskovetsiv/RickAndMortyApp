//
//  HeaderView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct HeaderView: View {
	// MARK: - States&Properties

	private var character: Character

	// MARK: - Init

	init(character: Character) {
		self.character = character
	}

	// MARK: - UI

    var body: some View {
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
		}
    }
}
