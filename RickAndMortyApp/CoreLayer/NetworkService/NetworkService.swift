//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Combine
import Foundation

/// Сервис, отвечающий за работу с сетью
final class NetworkService: INetworkService {
	// MARK: - Private properties

	private let session: URLSession = URLSession.shared

	// MARK: - Public methods

	/// Метод сервиса, отправляющий запрос в сеть и получающий ответ с  decodable T (дженерик)
	/// - Parameters:
	///   - path: Ссылка
	///   - needDecoding: Флаг, нужен ли декодинг
	///   - completion: Обработчик завершения (Result<T, Error>)
	public func sendRequest<T: Decodable>(
		path: String,
		needDecoding: Bool,
		completion: @escaping (Result<T, Error>) -> Void) {
			guard let url = URL(string: path) else {
				completion(.failure(NetworkError.badUrl))
				return
			}
			var urlRequest = URLRequest(url: url)
			urlRequest.httpMethod = "GET"
			session.dataTask(with: urlRequest) { data, _, error in
				if let error = error {
					completion(.failure(error))
					return
				}
				guard let data = data else {
					completion(.failure(NetworkError.badData))
					return
				}
				if needDecoding {
					do {
						let model = try JSONDecoder().decode(T.self, from: data)
						completion(.success(model))
					} catch {
						completion(.failure(NetworkError.badDecoding))
					}
				} else {
					if let data = data as? T {
						completion(.success(data))
					} else {
						completion(.failure(NetworkError.badData))
					}
				}
			}.resume()
		}

	/// Метод сервиса, отправляющий запрос в сеть и получающий ответ с  decodable T (дженерик)
	/// - Parameters:
	///   - path: Ссылка
	///   - needDecoding: Флаг, нужен ли декодинг
	///   - completion: Паблишер типа AnyPublisher<T, Error>
	public func sendRequest<T:Decodable>(path: String, needDecoding: Bool) -> AnyPublisher<T, Error> {
		guard let url = URL(string: path) else {
			fatalError("Invalid Url!")
		}
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "GET"
		let publisher: AnyPublisher<Data, Error> = session.dataTaskPublisher(for: urlRequest)
			.mapError { AnyError($0) }
			.map { $0.data }
			.eraseToAnyPublisher()
		if needDecoding {
			return publisher
				.decode(type: T.self, decoder: JSONDecoder())
				.eraseToAnyPublisher()
		} else {
			return publisher
				.tryMap { data in
					guard let decodedObject = data as? T else {
						throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Failed to convert data to \(T.self)."))
					}
					return decodedObject
				}
				.eraseToAnyPublisher()
		}
	}
}

