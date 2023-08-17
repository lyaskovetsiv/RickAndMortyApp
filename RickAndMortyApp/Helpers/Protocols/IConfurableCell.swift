//
//  IConfurableCell.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Протокол для конфигурации ячейки
protocol IConfurableCell {
	associatedtype ConfigurationModel
	func configure(with model: ConfigurationModel)
}
