//
//  InfoView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct InfoView: View {

	private var character: Character

	init(character: Character) {
		self.character = character
	}

	var body: some View {
		VStack {
			HStack {
				Text("Info")
				Spacer()
			}
			.padding(.leading, 24)
			ZStack {
				Color.groupColor
				VStack (spacing: -8) {
					HStack {
						Text("Species: ")
							.foregroundColor(Color.secondaryTextColor)
						Spacer()
						Text("\(character.species)")
					}
					.padding(16)
					HStack {
						Text("Type: ")
							.foregroundColor(Color.secondaryTextColor)
						Spacer()
						Text(character.type == "" ? "None" : "\(character.type)")
					}
					.padding(16)
					HStack {
						Text("Gender: ")
							.foregroundColor(Color.secondaryTextColor)
						Spacer()
						Text("\(character.gender)")
					}
					.padding(16)
				}
			}
			.cornerRadius(16)
			.frame(height: 124)
			.padding(24)
		}
	}
}
