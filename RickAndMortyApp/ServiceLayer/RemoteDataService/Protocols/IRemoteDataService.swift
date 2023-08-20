//
//  IRemoteDataService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Combine
import Foundation

/// Протокол сервиса для работы с сервером
protocol IRemoteDataService: AnyObject {
	func loadCharacters() -> AnyPublisher<ServerResponse, Error>
	func loadImage(from stringUrl: String) -> AnyPublisher<ImageModel, Error>
	func loadPlace(by url: String) -> AnyPublisher<Place,Error>
	func loadEpisode(by url: String) -> AnyPublisher<Episode,Error>
}
