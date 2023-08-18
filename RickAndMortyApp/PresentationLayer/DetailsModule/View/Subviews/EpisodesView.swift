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
			SectionHeader(text: "Episodes")
			VStack (spacing: -24) {
				ForEach(character.episode, id: \.self) { element in
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
									.font(Font.custom("Gilroy-Medium", size: 13))
									.foregroundColor(Color.greenFuxia)
								Spacer()
								Text("December 2, 2013")
									.font(Font.custom("Gilroy-Medium", size: 13))
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
	}
}
