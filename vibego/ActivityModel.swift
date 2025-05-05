//
//  ActivityModel.swift
//  Assessment 3
//
//  Created by Vanco CHOW on 5/4/25.
//

import Foundation

// Data Model representing an Activity suggestion

// 'Identifiable' allows the model to be used in SwiftUI lists and views requiring unique IDs
struct Activity: Identifiable {
    let id = UUID() // Automatically generate a unique ID for each activity
    let name: String        // Activity name/title (e.g., "Yoga Class")
    let type: String        // Mood-type match (e.g., "Chill", "Excited")
    let location: String    // Distance or location info (e.g., "2 km")
    let price: Int          // Cost in dollars (used for filtering or display)
    let description: String // Full details shown when user swipes up
}
