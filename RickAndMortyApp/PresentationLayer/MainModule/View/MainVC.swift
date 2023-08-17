//
//  MainVC.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import UIKit


/// Класс вью Main модуля
final class MainVC: UIViewController {

	var presenter: IMainPresenter?

	// MARK: - Private properties

	private var mainCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
		view.backgroundColor = .red
		view.showsVerticalScrollIndicator = false
		view.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
		return view
	}()

	private var characters: [String] = ["Rick Sanchez", "Morty Smith", "Summer Smith", "Beth Smith", "Rick Smith", "Morty Smith", "Summer Smith", "Beth Smith", "Rick Smith"]

	// MARK: - LifeCycleOfVC

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
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
}

// MARK: - IMainView

extension MainVC: IMainView {

}

// MARK: - UICollectionViewDataSource

extension MainVC: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		characters.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
			fatalError("Failed to load CharacterCell")
		}
		cell.configureCell(with: characters[indexPath.row])
		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension MainVC: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: 156, height: 202)
	}
}
