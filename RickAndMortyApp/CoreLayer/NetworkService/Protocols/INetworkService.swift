//
//  INetworkService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Combine
import Foundation

/// Протокол для работы с сетью
protocol INetworkService: AnyObject {
	func sendRequest<T: Decodable>(path: String, needDecoding: Bool, completion: @escaping (Result<T, Error>) -> Void)
	func sendRequest<T:Decodable>(path: String, needDecoding: Bool) -> AnyPublisher<T, Error>
}
