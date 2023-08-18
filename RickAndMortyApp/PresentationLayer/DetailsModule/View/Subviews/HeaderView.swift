//
//  HeaderView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct HeaderView: View {
	// MARK: - States&Properties

	@ObservedObject var viewModel: DetailsViewModel

	// MARK: - Init

	init(viewModel: DetailsViewModel) {
		self.viewModel = viewModel
	}

	// MARK: - UI

    var body: some View {
		VStack {
			AsyncImage(url: URL(string: viewModel.character.image ?? "")) { phase in
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
				Text("\(viewModel.character.name)")
					.font(Font.custom("Gilroy-Semibold", size: 22))
				Text("\(viewModel.character.status)")
					.font(Font.custom("Gilroy-Medium", size: 16))
					.foregroundColor(Color.greenFuxia)
			}
			.padding()
		}
    }
}
