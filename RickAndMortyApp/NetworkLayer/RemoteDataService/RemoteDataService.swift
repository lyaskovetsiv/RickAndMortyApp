//
//  RemoteDataService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

final class RemoteDataService: IRemoteDataService {

	public func loadCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
		guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
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
				let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
				completion(.success(serverResponse.results))
			} catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
}
