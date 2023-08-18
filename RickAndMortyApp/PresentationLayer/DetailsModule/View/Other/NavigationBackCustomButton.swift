//
//  NavigationBackCustomButton.swift
//  RickAndMortyApp
//
//  Created by Иван Лясковец on 18.08.2023.
//

import SwiftUI

struct NavigationBackCustomButton: View {
	// MARK: - States&Properties

	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		Button(action: {
			presentationMode.wrappedValue.dismiss()
		}) {
			Image(systemName: "chevron.backward")
				.resizable()
				.frame(width: 6, height: 12)
				.scaledToFit()
				.foregroundColor(.white)
				.padding(.leading, 16)
		}
	}
}
