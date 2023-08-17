//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Модель персонажа
struct Character: Codable {
	var name: String
	var image: String?
	var status: String
	var species: String
	var type: String
	var gender: String
}

