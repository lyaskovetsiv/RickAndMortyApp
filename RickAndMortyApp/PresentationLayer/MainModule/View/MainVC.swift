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
		view.backgroundColor = #colorLiteral(red: 0.01332889963, green: 0.04810451716, blue: 0.1187042817, alpha: 1)
		navigationController?.navigationBar.prefersLargeTitles = true
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

	private func loadImageFor(cell: CharacterCell, character: Character) {
		presenter?.getImage(url: character.image ?? "") { data in
			if let data = data {
				DispatchQueue.main.async {
					cell.updateImage(model: data)
				}
			}
		}
	}
}

// MARK: - IMainView

extension MainVC: IMainView {
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
		loadImageFor(cell: cell, character: character)
		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension MainVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let character = presenter.getCharacter(by: indexPath)
		let host = UIHostingController(rootView: DetailsView(character: character))
		navigationController?.pushViewController(host, animated: true)
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
