import SwiftUI

struct MoodSelectionView: View {
    @State private var selectedMood: String? = nil
    
    // 使用新的情绪词汇替换部分原有情绪
    let moods: [MoodOption] = [
        MoodOption(name: "Awesome", colors: [Color(hex: "ff9966"), Color(hex: "ff7e47")]),
        MoodOption(name: "Chill", colors: [Color(hex: "81d4fa"), Color(hex: "4fc3f7")]),
        MoodOption(name: "Excited", colors: [Color(hex: "ffcc80"), Color(hex: "ffb347")]),
        MoodOption(name: "Okay", colors: [Color(hex: "ffe0a1"), Color(hex: "ffd87d")]),
        MoodOption(name: "Lonely", colors: [Color(hex: "ce93d8"), Color(hex: "ba68c8")]),
        MoodOption(name: "Anxious", colors: [Color(hex: "a5d6a7"), Color(hex: "7bc47f")]),
        MoodOption(name: "Overwhelmed", colors: [Color(hex: "ef9a9a"), Color(hex: "e57373")]),
        MoodOption(name: "Great", colors: [Color(hex: "ffda7a"), Color(hex: "ffce45")]),
        MoodOption(name: "Meh", colors: [Color(hex: "d9d9d9"), Color(hex: "b3b3b3")])
    ]
    
    // 定义网格布局
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            // 返回按钮
            HStack {
                Button(action: {
                    // 添加返回操作
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // 标题文字 - 使用圆角字体
            Text("How are you\nfeeling right now?")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .foregroundColor(Color(hex: "333333"))
            
            // 心情选择网格
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(moods) { mood in
                    MoodCell(mood: mood, isSelected: selectedMood == mood.name) {
                        selectedMood = mood.name
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // 只有选择了心情才显示继续按钮
            if selectedMood != nil {
                NavigationLink(destination: BudgetSelectionView(selectedMood: selectedMood!)) {
                    Text("Continue")
                        .font(.system(size: 17, weight: .bold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
            }
        }
        .padding(.vertical)
        .navigationBarHidden(true)
        .background(Color.white)
    }
}

// 心情选项数据模型
struct MoodOption: Identifiable {
    let id = UUID()
    let name: String
    let colors: [Color]  // 渐变色
}

// 单个心情选择单元格
struct MoodCell: View {
    let mood: MoodOption
    let isSelected: Bool
    let onTap: () -> Void
    
    // 根据心情名称返回对应的表情符号（这里需要根据新的情绪调整）
    var faceSymbol: String {
        switch mood.name {
        case "Awesome": return "🥰"
        case "Great": return "😃"
        case "Chill": return "😌"
        case "Excited": return "😊"
        case "Okay": return "😐"
        case "Lonely": return "😔"
        case "Anxious": return "😐"
        case "Overwhelmed": return "🤯"
        case "Meh": return "🫤"
        default: return "😊"
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: mood.colors),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 90, height: 90)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                
                // wait to be replaced
                Text(faceSymbol)
                    .font(.system(size: 40))
            }
            .overlay(
                Circle()
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
            )
            
            // name of the mood
            Text(mood.name)
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "333333"))
        }
        .onTapGesture {
            onTap()
        }
    }
}

//color
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
