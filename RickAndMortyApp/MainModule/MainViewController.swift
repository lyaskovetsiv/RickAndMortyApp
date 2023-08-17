//
//  MainViewController.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import UIKit

final class MainViewController: UIViewController {
	// MARK: - Private properties

	private var mainCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		return view
	}()

	// MARK: - LifeCycleOfVC

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

// MARK: - Private methods

extension MainViewController {
	private func setupView() {
		title = "Characters"
		view.backgroundColor = #colorLiteral(red: 0.01332889963, green: 0.04810451716, blue: 0.1187042817, alpha: 1)
		navigationController?.navigationBar.prefersLargeTitles = true

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
