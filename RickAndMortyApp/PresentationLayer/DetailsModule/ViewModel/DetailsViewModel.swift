//
//  DetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import Foundation


/// Вью модель Details модуля
final class DetailsViewModel: ObservableObject {
	// MARK: - States&Properties

	@Published var character: Character
	@Published var place: Place?
	private var remoteDataService: IRemoteDataService
	private var moduleOutput: ModuleOutput

	// MARK: - Init

	init(character: Character, remoteDataService: IRemoteDataService, moduleOutput: ModuleOutput) {
		self.character = character
		self.remoteDataService = remoteDataService
		self.moduleOutput = moduleOutput
	}

	// MARK: - Public methods

	/// Метод вьюмодели для загрузки информации о месте персонажа
	public func loadPlace() {
		remoteDataService.loadPlace(by: character.origin.url) { result in
			switch result {
			case .success(let place):
				DispatchQueue.main.async { [weak self] in
					self?.place = place
				}
			case .failure(let error):
				print(error)
			}
		}
	}
}
