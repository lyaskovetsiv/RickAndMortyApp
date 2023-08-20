//
//  RemoteDataService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Combine
import Foundation
import UIKit

/// Класс сервиса, отвечающего за работу с сервером
final class RemoteDataService: IRemoteDataService {
	// MARK: - Private properies

	private var networkService: INetworkService
	private var imageCache = NSCache<NSString, UIImage>()
	private var path = "https://rickandmortyapi.com/api/character"

	// MARK: - Inits

	init(networkService: INetworkService) {
		self.networkService = networkService
	}

	// MARK: - Public methods

	/// Метод сервиса, который отвечает за загрузку персонажей
	/// - Returns: Паблишер типа AnyPublisher<ServerResponse, Error>
	public func loadCharacters() -> AnyPublisher<ServerResponse, Error> {
		networkService.sendRequest(path: path, needDecoding: true)
	}

	/// Метод сервиса, который отвечает за загрузку картинок
	/// - Parameter stringUrl: Ccskrf yf rfhnbyre
	/// - Returns: Паблишер типа AnyPublisher<ImageModel, Error>
	public func loadImage(from stringUrl: String) -> AnyPublisher<ImageModel, Error> {
		if let cachedImage = imageCache.object(forKey: NSString(string: stringUrl)) {
			let model = ImageModel(image: cachedImage)
			return Result.Publisher(.success(model)).eraseToAnyPublisher()
		} else {
			return Future { [weak self] promise in
				DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
					self?.networkService.sendRequest(path: stringUrl, needDecoding: false)
					{ (result: Result<Data, Error>) in
						switch result {
						case .success(let data):
							guard let image = UIImage(data: data) else {
								promise(.failure(NetworkError.badData))
								return
							}
							self?.imageCache.setObject(image, forKey: NSString(string: stringUrl))
							let model = ImageModel(image: image)
							promise(.success(model))
						case .failure(let error):
							promise(.failure(error))
						}
					}
				}
			}
			.eraseToAnyPublisher()
		}
	}

	/// Метод сервиса, который отвечает за загрузку Place
	/// - Parameters:
	///   - url: Ссылка
	///   - completion: Обработчик завершения
	public func loadPlace(by url: String, completion: @escaping (Result<Place, Error>) -> Void) {
		networkService.sendRequest(path: url, needDecoding: true) { (result: Result<Place, Error>) in
			switch result {
			case .success(let place):
				completion(.success(place))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	/// Метод сервиса, который отвечает за загрузку Эпизода
	/// - Parameters:
	///   - url: Ссылка
	///   - completion: Обработчик завершения
	public func loadEpisode(by url: String, completion: @escaping (Result<Episode, Error>) -> Void) {
		networkService.sendRequest(path: url, needDecoding: true) { (result: Result<Episode, Error>) in
			switch result {
			case .success(let episode):
				completion(.success(episode))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
