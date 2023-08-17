//
//  ModuleAssembly.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation
import UIKit

/// Класс ассебле модулей (экранов)
final class ModuleAssembly {
	static private var serviceAssembly: ServiceAssembly {
			return ServiceAssembly()
	}
	static let remoteDataService: IRemoteDataService = serviceAssembly.getRemoteDataService()

	/// Метод для сборки Main модуля
	/// - Returns: Обьект MainVC
	static func createMainModule() -> UIViewController {
		let view = MainVC()
		let presenter = MainPresenter(view: view,
									  remoteDataService: remoteDataService)
		view.presenter = presenter
		return view
	}
}
