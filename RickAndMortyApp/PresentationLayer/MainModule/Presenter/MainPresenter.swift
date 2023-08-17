//
//  MainPresenter.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Класс презентера Main модуля
final class MainPresenter: IMainPresenter {

	weak var view: IMainView?

	// MARK: - Private properties

	private var remoteDataService: IRemoteDataService
	private var characters: [Character] = []

	// MARK: - Init

	init(view: IMainView? = nil,
		 remoteDataService: IRemoteDataService) {
		self.view = view
		self.remoteDataService = remoteDataService
	}

	// MARK: - Public methods

	/// Метод презентера, обрабатывающий этап жц контроллера, когда вью загрузилась
	public func viewDidLoad() {
		remoteDataService.loadCharacters { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let characters):
				self.characters = characters
				DispatchQueue.main.async {
					self.view?.updateUI()
				}
			case .failure(let error):
				print(error.localizedDescription)
				DispatchQueue.main.async {
					self.view?.showAlert()
				}
			}
		}
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
	///   - completion: Обработчик завершения
	public func getImage(url: String, completion: @escaping (Data?) -> Void) {
		remoteDataService.loadImage(from: url) { result in
			switch result {
			case .success(let imageData):
				completion(imageData)
			case .failure(let error):
				completion(nil)
				print(error)
				// Обработать ошибку загрузки картинки
			}
		}
	}
}
