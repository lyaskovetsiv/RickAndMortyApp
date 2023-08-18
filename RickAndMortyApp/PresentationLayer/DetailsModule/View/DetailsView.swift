//
//  DetailsView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import SwiftUI

struct DetailsView: View {
	// MARK: - States&Properties
	@ObservedObject var viewModel: DetailsViewModel

	// MARK: - Init

	init(viewModel: DetailsViewModel) {
		self.viewModel = viewModel
	}

	// MARK: - UI

	var body: some View {
		ScrollView(showsIndicators: false) {
			ZStack {
				Color.backgroundColor
				VStack {
					HeaderView(viewModel: viewModel)
					InfoView(viewModel: viewModel)
					OriginView(viewModel: viewModel)
					EpisodesView(viewModel: viewModel)
				}
				.padding(.top, 100)
			}
			.navigationBarBackButtonHidden(true)
			.navigationBarItems(leading: NavigationBackCustomButton())
		}
		.ignoresSafeArea()
		.onAppear {
			Task {
				viewModel.loadPlace()
				viewModel.loadEpisodes()
			}
		}
	}
}
