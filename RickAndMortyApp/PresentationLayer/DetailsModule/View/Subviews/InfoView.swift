//
//  InfoView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct InfoView: View {
	// MARK: - States&Properties

	@ObservedObject var viewModel: DetailsViewModel

	// MARK: - Init

	init(viewModel: DetailsViewModel) {
		self.viewModel = viewModel
	}

	// MARK: - UI

	var body: some View {
		VStack {
			SectionHeader(text: "Info")
			ZStack {
				Color.groupColor
				VStack (spacing: -8) {
					HStack {
						Text("Species: ")
							.font(Font.custom("Gilroy-Semibold", size: 16))
							.foregroundColor(Color.secondaryTextColor)
						Spacer()
						Text("\(viewModel.character.species)")
							.font(Font.custom("Gilroy-Semibold", size: 16))
					}
					.padding(16)
					HStack {
						Text("Type: ")
							.font(Font.custom("Gilroy-Semibold", size: 16))
							.foregroundColor(Color.secondaryTextColor)
						Spacer()
						Text(viewModel.character.type == "" ? "None" : "\(viewModel.character.type)")
							.font(Font.custom("Gilroy-Semibold", size: 16))
					}
					.padding(16)
					HStack {
						Text("Gender: ")
							.font(Font.custom("Gilroy-Semibold", size: 16))
							.foregroundColor(Color.secondaryTextColor)
						Spacer()
						Text("\(viewModel.character.gender)")
							.font(Font.custom("Gilroy-Semibold", size: 16))
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
