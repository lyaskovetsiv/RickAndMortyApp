//
//  ServiceAssembly.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Класс ассебле сервисов
final class ServiceAssembly {
	/// Метод сервисного ассембле, который создает сервис по работе с сервером
	/// - Returns: Экземпляр сервиса IRemoteDataService
	public func getRemoteDataService () -> IRemoteDataService {
		return RemoteDataService(networkService: NetworkService())
	}
}
