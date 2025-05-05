//
//  FinalActivityView.swift
//  Assessment 3
//
//  Created by Vanco CHOW on 5/4/25.
//

import SwiftUI

struct FinalActivityView: View {
    let activity: Activity

    var body: some View {
        VStack(spacing: 20) {
            Text("🎉 Your Selected Activity")
                .font(.title)

            Text(activity.name)
                .font(.title2).bold()

            Text(activity.type)
                .foregroundColor(.gray)

            Text("📍 \(activity.location)")
            Text("💰 $\(activity.price)")
            Text("📝 \(activity.description)")
                .padding()

            NavigationLink(destination: MoodSelectionView()) {
                Text("Start Again")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 30)
        }
        .padding()
    }
}

#Preview {
    FinalActivityView(activity: Activity(
            name: "Sample Café",
            type: "Chill",
            location: "1.2 km",
            price: 10,
            description: "A relaxing café with good coffee."
        ))
}
