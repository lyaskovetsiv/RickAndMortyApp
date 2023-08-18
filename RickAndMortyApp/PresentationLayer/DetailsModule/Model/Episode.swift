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
		let startIndex = episode.index(episode.startIndex, offsetBy: 1)
		let endIndex = episode.index(episode.startIndex, offsetBy: 2)
		var result = episode[startIndex...endIndex]
		if result.first == "0" {
			result.removeFirst()
		}
		return String(result)
	}
	var ep: String {
		let startIndex = episode.index(episode.startIndex, offsetBy: 4)
		let endIndex = episode.index(episode.startIndex, offsetBy: 5)
		var result = episode[startIndex...endIndex]
		if result.first == "0" {
			result.removeFirst()
		}
		return String(result)
	}

}
