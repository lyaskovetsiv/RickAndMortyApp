//
//  MainVC.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import SwiftUI
import UIKit

/// Класс вью Main модуля
final class MainVC: UIViewController {

	var presenter: IMainPresenter!

	// MARK: - Private constants

	private enum Constants {
		static let backgroundColor: UIColor = #colorLiteral(red: 0.01332889963, green: 0.04810451716, blue: 0.1187042817, alpha: 1)
	}

	// MARK: - Private properties

	private var mainCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 16
		layout.minimumInteritemSpacing = 16
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
		view.showsVerticalScrollIndicator = false
		view.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
		return view
	}()

	// MARK: - LifeCycleOfVC

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		presenter?.viewDidLoad()
	}
}

// MARK: - Private methods

extension MainVC {
	private func setupView() {
		title = "Characters"
		view.backgroundColor = Constants.backgroundColor
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.backButtonTitle = ""
		mainCollectionView.dataSource = self
		mainCollectionView.delegate = self
		view.addSubview(mainCollectionView)
		setupConstraits()
	}

	private func setupConstraits() {
		mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

// MARK: - IMainView

extension MainVC: IMainView {
	/// Метод вью, обновляющий картинку в конкретной ячейке
	/// - Parameters:
	///   - model: Модель картинки
	///   - indexPath: Индекс ячейки
	public func updateImage(model: ImageModel?, for indexPath: IndexPath) {
		if let model = model {
			guard let cell = mainCollectionView.cellForItem(at: indexPath) as? CharacterCell else {
				return
			}
			cell.updateImage(model: model)
		}
	}

	/// Метод вью, обновляющий коллекцию
	public func updateUI() {
		mainCollectionView.reloadData()
	}

	/// Метод вью. отображающий всплывающее окно с ошибкой
	public func showAlert() {
		let alertVC = UIAlertController(title: "Oops!",
										message: "Failed by uploading data from network. Try to reload later!",
										preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok!", style: .default)
		alertVC.addAction(okAction)
		present(alertVC, animated: true)
	}
}

// MARK: - UICollectionViewDataSource

extension MainVC: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		presenter?.getNumberOfCharacters() ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
			fatalError("Failed to load CharacterCell")
		}
		let character = presenter.getCharacter(by: indexPath)
		cell.configure(with: character)
		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension MainVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter.characterTapped(indexPath: indexPath)
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard cell is CharacterCell else { fatalError("Failed to load CharacterCell")}
		let character = presenter.getCharacter(by: indexPath)
		presenter.getImage(url: character.image ?? "", by: indexPath)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let itemsPerLine = 2
		let itemWidth = UIScreen.main.bounds.width / CGFloat(itemsPerLine) - 32
		return CGSize(width: itemWidth, height: 202)
	}
}
