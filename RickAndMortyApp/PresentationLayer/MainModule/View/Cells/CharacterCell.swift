//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 17.08.2023.
//

import UIKit

/// Класс ячейки коллекции с персонажами
final class CharacterCell: UICollectionViewCell {
	// MARK: - Private constants

	private enum Constants {
		// Fonts
		static let nameLabelFont: UIFont? = UIFont(name: "Gilroy-ExtraBold", size: 16)
		// Colors
		static let nameLabelTintColor: UIColor = .white
		static let backgroundColor: UIColor = #colorLiteral(red: 0.1501607001, green: 0.1651832163, blue: 0.2201651633, alpha: 1)
		static let photoImageViewHeight: CGFloat = 140
		// Sizes
		static let cellCornerRadius: CGFloat = 16
		static let photoImageViewCornerRadius: CGFloat = 10
	}

	// MARK: - Private properties

	private var photoImageView: UIImageView = {
		let view = UIImageView(frame: .zero)
		view.layer.cornerRadius = Constants.photoImageViewCornerRadius
		view.clipsToBounds = true
		return view
	}()

	private var nameLabel: UILabel = {
		let view = UILabel(frame: .zero)
		view.tintColor = Constants.nameLabelTintColor
		view.font = Constants.nameLabelFont
		view.textAlignment = .center
		view.numberOfLines = 1
		return view
	}()

	private var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(frame: .zero)
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

	override func prepareForReuse() {
		clearCell()
	}

	// MARK: - Public methods

	public func updateImage(model: ImageModel) {
		if let image = model.image {
			photoImageView.image = image
			activityIndicator.stopAnimating()
			activityIndicator.isHidden = true
		}
	}
}

// MARK: - Private methods

extension CharacterCell {
	private func setupView() {
		backgroundColor = Constants.backgroundColor
		layer.cornerRadius = Constants.cellCornerRadius
		addSubview(photoImageView)
		photoImageView.addSubview(activityIndicator)
		addSubview(nameLabel)
		setupConstraits()
	}

	private func setupConstraits() {
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			photoImageView.heightAnchor.constraint(equalToConstant: Constants.photoImageViewHeight)
		])

		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
			nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
		])

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
		])
	}

	private func clearCell() {
		nameLabel.text = ""
		photoImageView.image = nil
	}
}

// MARK: - IReusableCell

extension CharacterCell: IReusableCell {
	static let identifier: String = "characterCell"
}

// MARK: - IConfurableCell

extension CharacterCell: IConfurableCell {
	typealias ConfigurationModel = Character
	/// Метод ячейки для ее настройки
	/// - Parameter model: Модель персонажа
	public func configure(with model: Character) {
		clearCell()
		nameLabel.text = model.name
		activityIndicator.startAnimating()
	}
}
