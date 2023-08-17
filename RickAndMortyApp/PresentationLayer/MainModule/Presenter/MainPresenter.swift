//
//  MainPresenter.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

final class MainPresenter: IMainPresenter {
	// MARK: - Public properties

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
				print(error)
			}
		}
	}

	
	public func getNumberOfCharacters() -> Int {
		characters.count
	}

	public func getCharacter(by indexPath: IndexPath) -> Character {
		characters[indexPath.item]
	}

	public func getImage(url: String, completion: @escaping (Data?) -> Void) {
		remoteDataService.loadImage(from: url) { result in
			switch result {
			case .success(let model):
				completion(model)
			case .failure(let error):
				print(error.localizedDescription)
				completion(nil)
			}
		}
	}
}
