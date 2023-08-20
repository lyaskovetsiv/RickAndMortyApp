//
//  AnyError.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 20.08.2023.
//

import Foundation

struct AnyError: Error {
	let error: Error

	init(_ error: Error) {
		self.error = error
	}
}
