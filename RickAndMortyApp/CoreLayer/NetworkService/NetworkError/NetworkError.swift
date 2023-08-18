//
//  NetworkError.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Перечисление с ошибками при работе с удаленным сервером
enum NetworkError: Error {
	case badUrl
	case badData
	case badDecoding
}

// MARK: - CustomStringConvertible

extension NetworkError: CustomStringConvertible {
	var description: String {
		switch self {
		case .badUrl:
			return "Failed to get URL from string"
		case .badData:
			return "Failed by getting data"
		case .badDecoding:
			return "Failed while decoding"
		}
	}
}
