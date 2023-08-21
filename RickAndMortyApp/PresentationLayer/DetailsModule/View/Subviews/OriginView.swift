//
//  OriginView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct OriginView: View {
	// MARK: - States&Properties

	@ObservedObject var viewModel: DetailsViewModel

	// MARK: - Init

	init(viewModel: DetailsViewModel) {
		self.viewModel = viewModel
	}

	// MARK: - UI

	var body: some View {
		VStack(spacing: 0) {
			SectionHeader(text: "Origin")
			if viewModel.isPlaceEmpty() {
				ProgressView()
					.padding(24)
			} else {
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
							Text(viewModel.place.name)
								.font(Font.custom("Gilroy-Semibold", fixedSize: 17))
							Text(viewModel.place.type)
								.font(Font.custom("Gilroy-Medium", size: 13))
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
}
