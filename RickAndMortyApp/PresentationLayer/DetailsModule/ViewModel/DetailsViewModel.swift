//
//  DetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import Combine
import Foundation

/// Вью модель Details модуля
final class DetailsViewModel: ObservableObject {
	// MARK: - States&Properties

	@Published var character: Character
	@Published var place: Place = Place(name: "", type: "")
	@Published var episodes: [Episode] = []
	@Published var errorMessage = ""
	@Published var showingError: Bool = false
	private var remoteDataService: IRemoteDataService
	private var moduleOutput: ModuleOutput
	private var cancellables = Set<AnyCancellable>()

	// MARK: - Init

	/// Инициализатор вьюмодели Details модуля
	/// - Parameters:
	///   - character: Модель персонажа
	///   - remoteDataService: Сервис для работы с сервером
	///   - moduleOutput: Координатор
	init(character: Character, remoteDataService: IRemoteDataService, moduleOutput: ModuleOutput) {
		self.character = character
		self.remoteDataService = remoteDataService
		self.moduleOutput = moduleOutput
	}

	// MARK: - Public methods

	/// Метод вьюмодели для загрузки информации о месте персонажа
	public func loadPlace() {
		remoteDataService.loadPlace(by: character.origin.url)
			.subscribe(on: DispatchQueue.global(qos: .userInitiated))
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				if case let .failure(error) = completion {
					print(error.localizedDescription)
					self?.errorMessage = "Missed data from server: place"
					self?.showingError = true
				}
			}, receiveValue: { [weak self] place in
				self?.place = place
			})
			.store(in: &cancellables)
	}

	/// Метод вьюмодели для загрузки информации об эпизодах
	public func loadEpisodes() {
		for episode in character.episode {
			remoteDataService.loadEpisode(by: episode)
				.subscribe(on: DispatchQueue.global(qos: .userInitiated))
				.receive(on: DispatchQueue.main)
				.sink { [weak self] completion in
					if case let .failure(error) = completion {
						print(error.localizedDescription)
						self?.errorMessage = "Missed data from server: episodes"
						self?.showingError = true
					}
				} receiveValue: { [weak self] episode in
					self?.episodes.append(episode)
				}
				.store(in: &cancellables)
		}
	}
}
