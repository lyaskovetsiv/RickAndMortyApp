//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Модель персонажа
struct Character: Codable {
	let name: String
	let image: String?
	let status: String
	let species: String
	let type: String
	let gender: String
	let origin: Origin
	let episode: [String]
}

struct Origin: Codable {
	let name: String
	let url: String
}

