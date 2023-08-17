//
//  IMainPresenter.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import Foundation


/// Протокол презентера Main модуля
protocol IMainPresenter: AnyObject {
	func viewDidLoad()
	func getNumberOfCharacters() -> Int
	func getCharacter(by indexPath: IndexPath) -> Character
	func getImage(url: String, completion: @escaping (Data?) -> Void)
}
