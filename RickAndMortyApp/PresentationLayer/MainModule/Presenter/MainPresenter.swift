//
//  MainPresenter.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

final class MainPresenter: IMainPresenter {

	weak var view: IMainView?

	private var remoteDataService: IRemoteDataService

	// MARK: - Init

	init(view: IMainView? = nil,
		 remoteDataService: IRemoteDataService) {
		self.view = view
		self.remoteDataService = remoteDataService
	}
}
