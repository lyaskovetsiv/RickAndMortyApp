//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import Foundation

struct Episode: Codable {
	let name: String
	let air_date: String
	let episode: String
	var season: String {
		getSubstring(from: episode, index1: 1, index2: 2)
	}
	var ep: String {
		getSubstring(from: episode, index1: 4, index2: 5)
	}

	private func getSubstring(from string: String, index1: Int, index2: Int) -> String {
		let startIndex = string.index(string.startIndex, offsetBy: index1)
		let endIndex = string.index(string.startIndex, offsetBy: index2)
		var result = string[startIndex...endIndex]
		if result.first == "0" {
			result.removeFirst()
		}
		return String(result)
	}

}
