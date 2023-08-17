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

	public func loadImage(from stringUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
		guard let url = URL(string: stringUrl) else {
			completion(.failure(NetworkError.badUrl))
			return
		}
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			if let error = error {
				completion(.failure(error))
			}
			guard let data = data else {
				print(error)
				return
			}
			do {
				completion(.success(data))
			} catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
}
