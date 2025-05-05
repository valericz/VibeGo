//
//  DistanceSelectionView.swift
//  Assessment 3
//
//  Created by Vanco CHOW on 5/4/25.
//

import SwiftUI

struct DistanceSelectionView: View {
    var selectedMood: String
    var budget: Int
    @State private var selectedDistance: String? = nil

    let distances = [
        ("Walkable", "0–2 km"),
        ("Short Ride", "2–8 km"),
        ("Up for a Journey", "8+ km")
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("How far are you willing to go?")
                .font(.title2)
                .padding()

            // Distance options with selection toggle
            ForEach(distances, id: \.0) { option in
                Button(action: {
                    selectedDistance = option.0
                }) {
                    HStack {
                        Image(systemName: selectedDistance == option.0 ? "checkmark.circle.fill" : "circle")
                        Text("\(option.0) (\(option.1))")
                            .font(.body)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                }
            }

            // Navigate to next screen
            if let distance = selectedDistance {
                NavigationLink(destination: TimeSelectionView(
                    selectedMood: selectedMood,
                    budget: budget,
                    distance: distance
                )) {
                    Text("Next")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
            }
        }
        .padding()
    }
}

#Preview {
    DistanceSelectionView(selectedMood: "Chill", budget: 10)
}
