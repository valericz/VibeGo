//
//  SuggestionsView.swift
//  Assessment 3
//
//  Created by Vanco CHOW on 5/4/25.
//

import SwiftUI

// Sample activities to simulate results – you can later replace this with real data
let sampleActivities = [
    Activity(name: "Local Café", type: "Chill", location: "2 km", price: 10, description: "A cozy café to relax and recharge."),
    Activity(name: "Art Gallery", type: "Excited", location: "4 km", price: 20, description: "Inspiring exhibitions to lift your mood."),
    Activity(name: "Yoga Class", type: "Lonely", location: "1 km", price: 15, description: "Great for mindfulness and social connection."),
    Activity(name: "Park Walk", type: "Overwhelmed", location: "0.5 km", price: 0, description: "Relaxing walk in the nature.")
]

// MARK: - Main Suggestions View showing swipe cards
struct SuggestionsView: View {
    var mood: String
    var budget: Int
    var distance: String
    var time: String

    // State variables to control dynamic content
    @State private var activities = sampleActivities.shuffled() // Randomize cards each time
    @State private var currentIndex = 0                          // Tracks current card index
    @State private var offset = CGSize.zero                      // Stores swipe gesture movement
    @State private var showDetail = false                        // Controls detail sheet
    @State private var selectedActivity: Activity? = nil         // Stores selected activity on swipe right

    var body: some View {
        VStack {
            if currentIndex < activities.count {
                // Get the current activity to display
                let activity = activities[currentIndex]

                ZStack {
                    // Card background
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 10)

                    // Card content
                    VStack(spacing: 10) {
                        Text(activity.name)
                            .font(.title2).bold()

                        Text(activity.type)
                            .font(.subheadline)

                        Text("Location: \(activity.location)")
                        Text("Price: $\(activity.price)")
                    }
                    .padding()
                }
                .frame(height: 300)
                .padding()

                // Card swipe interaction
                .offset(offset)
                .rotationEffect(.degrees(Double(offset.width / 20))) // Rotate slightly while swiping

                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            // Update offset as user drags the card
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            // Interpret swipe direction
                            if offset.width > 100 {
                                // Swipe right – selected activity
                                selectedActivity = activities[currentIndex]
                            } else if offset.width < -100 {
                                // Swipe left – skip
                                currentIndex += 1
                            } else if offset.height < -100 {
                                // Swipe up – show more info
                                showDetail = true
                            }
                            // Reset offset
                            offset = .zero
                        }
                )

                // Sheet showing more information when swiped up
                .sheet(isPresented: $showDetail) {
                    VStack(spacing: 20) {
                        Text("More Info")
                            .font(.title)

                        Text(activity.description)
                            .padding()

                        Button("Close") {
                            showDetail = false
                        }
                        .padding()
                    }
                }

            } else {
                // No more activities to show
                Text("No more suggestions")
                    .font(.headline)

                NavigationLink(destination: MoodSelectionView()) {
                    Text("Start Again")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }

        // Show FinalActivityView when user swipes right
        .sheet(item: $selectedActivity) { activity in
            FinalActivityView(activity: activity)
        }
    }
}

#Preview {
    SuggestionsView(mood: "Chill", budget: 30, distance: "1km", time: "1hr")
}
