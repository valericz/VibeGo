import SwiftUI

struct BudgetSelectionView: View {
    let selectedMood: String
    @State private var budget: Double = 50 // 默认值50
    

    let minBudget: Double = 0
    let maxBudget: Double = 100
    
  
    let budgetLabels = ["Basic", "Standard", "Premium"]
    
    var body: some View {
        VStack(spacing: 40) {
        
            HStack {
                Button(action: {
               
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            
        
            Text("What's your budget?")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(.black.opacity(0.8))
            
            ZStack {
                Circle()
                    .fill(budgetGradient)
                    .frame(width: 120, height: 120)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                
                VStack {
                    Text("$\(Int(budget))")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(getBudgetLevel())
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            .padding(.vertical, 20)
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation { budget = 0 }
                }) {
                    Text(budgetLabels[0])
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            isNearValue(0)
                            ? budgetGradient
                            : LinearGradient(
                                gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.1)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .foregroundColor(isNearValue(0) ? .white : .black)
                        .cornerRadius(20)
                }
                
                Button(action: {
                    withAnimation { budget = maxBudget / 2 }
                }) {
                    Text(budgetLabels[1])
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            isNearValue(maxBudget / 2)
                            ? budgetGradient
                            : LinearGradient(
                                gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.1)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .foregroundColor(isNearValue(maxBudget / 2) ? .white : .black)
                        .cornerRadius(20)
                }
                
                Button(action: {
                    withAnimation { budget = maxBudget }
                }) {
                    Text(budgetLabels[2])
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            isNearValue(maxBudget)
                            ? budgetGradient
                            : LinearGradient(
                                gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.1)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .foregroundColor(isNearValue(maxBudget) ? .white : .black)
                        .cornerRadius(20)
                }
            }
            .padding(.bottom, 20)
            
    
            VStack(spacing: 10) {
            
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 12)
                    
                    
                    Capsule()
                        .fill(budgetGradient)
                        .frame(width: CGFloat(budget / maxBudget) * UIScreen.main.bounds.width * 0.8, height: 12)
                }
             
                Slider(value: $budget, in: minBudget...maxBudget)
                    .accentColor(.clear)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8)
            
            Spacer()
            
        
            NavigationLink(destination: DistanceSelectionView(selectedMood: selectedMood, budget: Int(budget))) {
                Text("Continue")
                    .font(.system(size: 17, weight: .bold))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
        }
    }
    
  
    private func getBudgetLevel() -> String {
        if budget < maxBudget / 3 {
            return "Basic"
        } else if budget < maxBudget * 2 / 3 {
            return "Standard"
        } else {
            return "Premium"
        }
    }
    
    // check the current budget
    private func isNearValue(_ value: Double) -> Bool {
        return abs(budget - value) < 5
    }
    
    // color base on budget
    var budgetGradient: LinearGradient {
        if budget < maxBudget / 3 {
           //high budget
            return LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
        } else if budget < maxBudget * 2 / 3 {
            
            return LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.7), Color.green.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
        
            return LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.7), Color.orange.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

struct BudgetSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSelectionView(selectedMood: "Happy")
    }
}
