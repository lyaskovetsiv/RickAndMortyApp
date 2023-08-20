//
//  MainPresenter.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Combine
import Foundation

/// Класс презентера Main модуля
final class MainPresenter: IMainPresenter {

	weak var view: IMainView?

	// MARK: - Private properties

	private var moduleOutput: ModuleOutput
	private var remoteDataService: IRemoteDataService
	private var characters: [Character] = []
	private var cancellables = Set<AnyCancellable>()

	// MARK: - Init

	init(view: IMainView? = nil,
		 remoteDataService: IRemoteDataService,
		 moduleOutput: ModuleOutput) {
		self.view = view
		self.remoteDataService = remoteDataService
		self.moduleOutput = moduleOutput
	}

	// MARK: - Public methods

	/// Метод презентера, обрабатывающий этап жц контроллера, когда вью загрузилась
	public func viewDidLoad() {
		remoteDataService.loadCharacters()
			.subscribe(on: DispatchQueue.global(qos: .userInitiated))
			.receive(on: DispatchQueue.main)
			.sink { [weak self] completion in
				if case let .failure(error) = completion {
					print(error.localizedDescription)
					self?.view?.showAlert()
				}
			} receiveValue: { [weak self] result in
				self?.characters = result.results
				self?.view?.updateUI()
			}
			.store(in: &cancellables)
	}

	/// Метод презентера, вовращающий количество персонадей
	/// - Returns: Количество персонажей
	public func getNumberOfCharacters() -> Int {
		return characters.count
	}

	/// Метод презентера, возвращающий персонажа по индексу
	/// - Parameter indexPath: Индекс
	/// - Returns: Модель с персонажем
	public func getCharacter(by indexPath: IndexPath) -> Character {
		return characters[indexPath.item]
	}
	/// Метод презентера, выполняющий загрузку картинки для персонажа
	/// - Parameters:
	///   - url: Адрес картинки
	///   - indexPath: Индекс ячекйи
	public func getImage(url: String, by indexPath: IndexPath) {
		remoteDataService.loadImage(from: url)
			.subscribe(on: DispatchQueue.global(qos: .userInitiated))
			.receive(on: DispatchQueue.main)
			.sink { [weak self] completion in
				if case let .failure(error) = completion {
					print(error.localizedDescription)
				}
			} receiveValue: { [weak self] result in
				self?.view?.updateImage(model: result, for: indexPath)
			}
			.store(in: &cancellables)
	}

	/// Метод презентера, обрабатывающий нажатие на иконку с персонажем
	/// - Parameter indexPath: Индекс ячейки с персонажем
	public func characterTapped(indexPath: IndexPath) {
		let character = characters[indexPath.item]
		moduleOutput.wantToOpenDetailsModule(character: character)
	}
}
