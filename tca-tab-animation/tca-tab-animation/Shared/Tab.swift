import SwiftUI

enum Tab: String {
    case one
    case two
    case three
    
    var title: String {
        return self.rawValue.capitalized
    }
    
    var icon: String {
        switch self {
        case .one: return "01.square"
        case .two: return "02.square"
        case .three: return "03.square"
        }
    }
}

struct FloatingTabView: View {
    @Namespace private var animation
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 4) {
            TabBarButton(
                tab: Tab.one,
                selectedTab: $selectedTab,
                animationNamespace: animation
            )
            
            TabBarButton(
                tab: Tab.two,
                selectedTab: $selectedTab,
                animationNamespace: animation
            )
            
            TabBarButton(
                tab: Tab.three,
                selectedTab: $selectedTab,
                animationNamespace: animation
            )
        }
        .padding(.vertical, -3)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.tertiary)
                .shadow(color: Color.black.opacity(0.25), radius: 4)
        }
    }
}

struct TabBarButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let animationNamespace: Namespace.ID
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Image(systemName: tab.icon)
                .resizable()
                .renderingMode(.template)
                .scaledToFill()
                .frame(width: 20, height: 20)
            Text(tab.title)
                .font(.subheadline)
        }
        .foregroundColor(selectedTab == tab ? .black : .gray)
        .padding(.horizontal, 10)
        .padding(.vertical, 9)
        .background {
            if selectedTab == tab {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.blue)
                    .matchedGeometryEffect(id: "selectedTabBG", in: animationNamespace)
                    .transition(.scale(scale: 1)) // prevents default opacity in transition
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                selectedTab = tab
            }
        }
    }
}

