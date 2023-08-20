//
//  EpisodesView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct EpisodesView: View {
	// MARK: - States&Properties
	
	@ObservedObject var viewModel: DetailsViewModel
	
	// MARK: - Init
	
	init(viewModel: DetailsViewModel) {
		self.viewModel = viewModel
	}
	
	// MARK: - UI
	
	var body: some View {
		VStack(spacing: 0) {
			SectionHeader(text: "Episodes")
			VStack (spacing: -24) {
				ForEach(viewModel.episodes, id: \.name) { episode in
					ZStack {
						Color.groupColor
						VStack {
							HStack {
								Text(episode.name)
									.font(Font.custom("Gilroy-ExtraBold", size: 17))
								Spacer()
							}
							.padding(16)
							HStack {
								Text("Episode: \(episode.ep), Season: \(episode.season)")
									.font(Font.custom("Gilroy-Medium", size: 13))
									.foregroundColor(Color.greenFuxia)
								Spacer()
								Text(episode.air_date)
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
