//
//  ServerResponse.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Модель серверного ответа
struct ServerResponse: Codable {
	var results: [Character]
}
