//
//  ServiceAssembly.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Класс ассебле сервисов
final class ServiceAssembly {
	public func getRemoteDataService () -> IRemoteDataService {
		return RemoteDataService()
	}
}
