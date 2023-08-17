//
//  IMainView.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation

/// Протокол вью Main модуля
protocol IMainView: AnyObject {
	func updateUI()
	func showAlert()
}
