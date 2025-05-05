//
//  TimeSelectionView.swift
//  Assessment 3
//
//  Created by Vanco CHOW on 5/4/25.
//

import SwiftUI

struct TimeSelectionView: View {
    var selectedMood: String
    var budget: Int
    var distance: String
    @State private var selectedTime: String? = nil

    let timeOptions = ["30 minutes", "1 hour", "2–3 hours", "Whole afternoon (3–8 hrs)"]

    var body: some View {
        VStack(spacing: 20) {
            Text("How much time do you have?")
                .font(.title2)
                .padding()

            // Time selection buttons
            ForEach(timeOptions, id: \.self) { option in
                Button(action: {
                    selectedTime = option
                }) {
                    HStack {
                        Image(systemName: selectedTime == option ? "clock.fill" : "clock")
                        Text(option)
                            .font(.body)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                }
            }

            // Proceed to activity suggestion
            if let time = selectedTime {
                NavigationLink(destination: SuggestionsView(
                    mood: selectedMood,
                    budget: budget,
                    distance: distance,
                    time: time
                )) {
                    Text("Get Suggestions")
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
    TimeSelectionView(selectedMood: "Chill", budget: 10, distance: "1km")
}
