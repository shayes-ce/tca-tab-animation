import ComposableArchitecture
import SwiftUI

@ViewAction(for: AppFeature.self)
struct AppView: View {
    @Perception.Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        TabView(selection: $store.selectedTab) {
            NavigationStack {
                Text("Tab 1 Content")
            }
            .toolbar(.hidden, for: .tabBar)
            .tag(Tab.one)
            
            NavigationStack {
                Text("Tab 2 Content")
            }
            .toolbar(.hidden, for: .tabBar)
            .tag(Tab.two)
            
            NavigationStack {
                Text("Tab 3 Content")
            }
            .toolbar(.hidden, for: .tabBar)
            .tag(Tab.three)
        }
        .overlay(alignment: .bottom) {
            FloatingTabView(selectedTab: $store.selectedTab)
                .padding(.horizontal)
                .padding(.bottom, 20)
                .withPerceptionTracking()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .withPerceptionTracking()
    }
}

// MARK: - Custom
struct PerceptionTrackingViewModifier: ViewModifier {
    @State private var id = 0
    
    func body(content: Content) -> some View {
        _ = self.id
        
        return withPerceptionTracking {
            _withoutPerceptionChecking {
                content
            }
        } onChange: {
            Task { @MainActor in self.id += 1 }
        }
    }
}

extension View {
    @MainActor func withPerceptionTracking() -> some View {
        self.modifier(PerceptionTrackingViewModifier())
    }
}
