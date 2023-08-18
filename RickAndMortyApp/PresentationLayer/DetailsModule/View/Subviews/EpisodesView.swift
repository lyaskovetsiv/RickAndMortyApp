//
//  EpisodesView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct EpisodesView: View {
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
				Text("Episodes")
				Spacer()
			}
			.padding(.leading, 24)
			ZStack {
				Color.groupColor
				VStack {
					HStack {
						Text("Pilot")
							.font(Font.custom("Gilroy-ExtraBold", fixedSize: 17))
						Spacer()
					}
					.padding(16)
					HStack {
						Text("Episode: 1, Season: 1")
							.font(Font.custom("Gilroy-Light", size: 13))
							.foregroundColor(Color.greenFuxia)
						Spacer()
						Text("December 2, 2013")
							.font(Font.custom("Gilroy-Light", size: 13))
							.foregroundColor(Color.secondaryTextColor)
					}
					.padding(.horizontal, 16)
					.padding(.bottom, 16)
				}
			}
			.cornerRadius(16)
			.frame(height: 86)
			.padding(24)
		}
	}
}
