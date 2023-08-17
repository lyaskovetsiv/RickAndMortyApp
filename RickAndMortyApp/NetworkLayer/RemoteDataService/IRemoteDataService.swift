//
//  IRemoteDataService.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

protocol IRemoteDataService: AnyObject {
	func loadCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
	func loadImage(from stringUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}
