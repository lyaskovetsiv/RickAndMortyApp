//
//  Coordinator.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import Foundation
import SwiftUI
import UIKit

/// Протокол координатора для модуля с каналом
protocol ModuleOutput: AnyObject {
	func wantToOpenDetailsModule(character: Character)
	func wantToCloseDetailesModule()
}

/// Координатор модулей с чатами
final class Coordinator: ModuleOutput {
	// MARK: - Private propertiesb

	private var navigationController: UINavigationController
	private var rootVC: UIViewController?

	// MARK: - Inits

	/// Инициализатор Coordinator
	/// - Parameter navigationVC: Навигационный контроллер
	init(navigationVC: UINavigationController) {
		self.navigationController = navigationVC
		let vc = ModuleAssembly.createMainModule(coordinator: self)
		self.navigationController.pushViewController(vc, animated: true)
		self.rootVC = vc
	}

	// MARK: - Public methods

	/// Метод координатора, который производит переход в окно с персонажем
	/// - Parameter model: Модель с юзером
	public func wantToOpenDetailsModule(character: Character) {
		let vc = ModuleAssembly.createDetailesModule(character: character, coordinator: self)
		let host = UIHostingController(rootView: vc)
		self.navigationController.pushViewController(host, animated: true)
	}

	/// Метод координатора, который производит закрытие экрана с персонажем
	public func wantToCloseDetailesModule() {
		navigationController.popViewController(animated: true)
	}
}
