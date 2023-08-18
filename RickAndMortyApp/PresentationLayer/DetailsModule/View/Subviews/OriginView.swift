//
//  OriginView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct OriginView: View {
	// MARK: - States&Properties

	private var character: Character

	// MARK: - Init

	init(character: Character) {
		self.character = character
	}

	// MARK: - UI

	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text("Origin")
				Spacer()
			}
			.padding(.leading, 24)
			ZStack {
				Color.groupColor
				HStack {
					ZStack {
						Image("planet")
							.resizable()
							.scaledToFit()
							.frame(width: 24, height: 24)
					}
					.frame(width: 64, height: 64)
					.background(Color.planetBackground)
					.cornerRadius(10)
					.padding(8)
					VStack (alignment: .leading, spacing: 8) {
						Text(character.origin.name)
							.font(Font.custom("Gilroy-ExtraBold", fixedSize: 17))
						#warning("Нужен запрос в сеть и модель для локации")
						Text("Planet")
							.font(Font.custom("Gilroy-Light", size: 13))
							.foregroundColor(Color.greenFuxia)
					}
					Spacer()
					Spacer()
				}
			}
			.cornerRadius(16)
			.frame(height: 80)
			.padding(24)
		}
	}
}
