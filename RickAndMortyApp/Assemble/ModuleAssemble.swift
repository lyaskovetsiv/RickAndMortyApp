//
//  ModuleAssemble.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation
import UIKit

/// Класс ассебле модулей (экранов)
final class ModuleAssembly {
	/// Метод для сборки Main модуля
	/// - Returns: Обьект MainVC
	static func createMainModule() -> UIViewController {
		let view = MainVC()
		let presenter = MainPresenter(view: view)
		view.presenter = presenter
		return view
	}
}
