//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import UIKit

final class CharacterCell: UICollectionViewCell {

	static let identifier: String = "characterCell"

	private var photoImageView: UIImageView = {
		let view = UIImageView(frame: .zero)
		view.backgroundColor = .yellow
		view.layer.cornerRadius = 10
		return view
	}()

	private var nameLabel: UILabel = {
		let view = UILabel(frame: .zero)
		view.tintColor = .white
		view.font = .systemFont(ofSize: 15)
		view.textAlignment = .center
		view.numberOfLines = 1
		return view
	}()

	// MARK: - Inits

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	public func configureCell(with model: Character) {
		nameLabel.text = model.name
	}
}

// MARK: - Private methods

extension CharacterCell {
	private func setupView() {
		backgroundColor = #colorLiteral(red: 0.1501607001, green: 0.1651832163, blue: 0.2201651633, alpha: 1)
		layer.cornerRadius = 16
		addSubview(photoImageView)
		addSubview(nameLabel)
		setupConstraits()
	}

	private func setupConstraits() {
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			photoImageView.heightAnchor.constraint(equalToConstant: 140)
		])

		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
			nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
		])
	}
}
