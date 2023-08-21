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
	@State private var showingOrigin: Bool = true
	@State private var showingEpisodes: Bool = true

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
					if showingOrigin {
						OriginView(viewModel: viewModel)
					}
					if showingEpisodes {
						EpisodesView(viewModel: viewModel)
					}
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
		.alert("Oops", isPresented: $viewModel.showingError) {
			Button {
				viewModel.showingError = false
				if viewModel.isPlaceEmpty() {
					showingOrigin = false
				}
				if viewModel.isEpisodesEmpty() {
					showingEpisodes = false
				}
			} label: {
				Text("OK!")
			}
		} message: {
			Text(viewModel.errorMessage)
		}
	}
}
