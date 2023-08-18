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
	// MARK: - Static properties

	static private var serviceAssembly: ServiceAssembly {
			return ServiceAssembly()
	}
	static let remoteDataService: IRemoteDataService = serviceAssembly.getRemoteDataService()

	// MARK: - Static methods

	/// Метод для сборки Main модуля
	/// - Parameter coordinator: Координатор
	/// - Returns: Вью Main модуля
	static func createMainModule(coordinator: ModuleOutput) -> UIViewController {
		let view = MainVC()
		let presenter = MainPresenter(view: view,
									  remoteDataService: remoteDataService,
									  moduleOutput: coordinator)
		view.presenter = presenter
		return view
	}

	/// Метод для сборки Details модуля
	/// - Parameters:
	///   - character: Модель персонажа
	///   - coordinator: Координатор
	/// - Returns: Вью Details модуля
	static func createDetailesModule(character: Character, coordinator: ModuleOutput) -> DetailsView {
		let viewModel = DetailsViewModel(character: character, remoteDataService: remoteDataService, moduleOutput: coordinator)
		let view = DetailsView(viewModel: viewModel)
		return view
	}
}
