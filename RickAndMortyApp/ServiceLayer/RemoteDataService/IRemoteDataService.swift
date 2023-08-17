//
//  IRemoteDataService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Протокол сервиса для работы с сервером
protocol IRemoteDataService: AnyObject {
	func loadCharacters(completion: @escaping (Result<ServerResponse, Error>) -> Void)
	func loadImage(from stringUrl: String, completion: @escaping (Result<ImageModel, Error>) -> Void)
}
