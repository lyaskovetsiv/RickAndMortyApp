//
//  NetworkError.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
	var description: String {
		switch self {
		case .badUrl:
			return "Failed to get URL from string"
		}
	}

	case badUrl
}
