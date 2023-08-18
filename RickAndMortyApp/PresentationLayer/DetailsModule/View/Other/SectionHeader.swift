//
//  SectionHeader.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct SectionHeader: View {
	// MARK: - States&Properties

	private var text: String

	// MARK: - Init

	init(text: String) {
		self.text = text
	}

	// MARK: - UI

	var body: some View {
		HStack {
			Text(text)
				.font(Font.custom("Gilroy-Semibold", size: 17))
			Spacer()
		}
		.padding(.leading, 24)
	}
}
