//
//  RemoteDataService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation
import UIKit

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
	public func loadImage(from stringUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
		networkService.sendRequest(path: stringUrl, needDecoding: false) { (result: Result<Data, Error>) in
			switch result {
			case .success(let data):
				completion(.success(data))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
