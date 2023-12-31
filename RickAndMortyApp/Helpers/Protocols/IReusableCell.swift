//
//  IReusableCell.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Протокол для переиспользования ячейки
protocol IReusableCell: AnyObject {
	static var identifier: String { get }
}
