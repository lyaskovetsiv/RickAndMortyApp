//
//  RemoteDataService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

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
	/// - Parameter completion: Обработчик завершения
	public func loadCharacters(completion: @escaping (Result<ServerResponse, Error>) -> Void) {
		networkService.sendRequest(path: path, needDecoding: true) { (result: Result<ServerResponse, Error>) in
			switch result {
			case .success(let response):
				completion(.success(response))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	/// Метод сервиса, который отвечает за загрузку картинок
	/// - Parameter completion: Обработчик завершения
	public func loadImage(from stringUrl: String, completion: @escaping (Result<ImageModel, Error>) -> Void) {
		if let cachedImage = imageCache.object(forKey: NSString(string: stringUrl)) {
			let model = ImageModel(image: cachedImage)
			completion(.success(model))
		} else {
			DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self]  in
				self?.networkService.sendRequest(path: stringUrl, needDecoding: false) { (result: Result<Data, Error>) in
					switch result {
					case .success(let data):
						guard let image = UIImage(data: data) else {
							completion(.failure(NetworkError.badData))
							return
						}
						self?.imageCache.setObject(image, forKey: NSString(string: stringUrl))
						let model = ImageModel(image: image)
						completion(.success(model))
					case .failure(let error):
						completion(.failure(error))
					}
				}
			}
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
