import ComposableArchitecture
import SwiftUI

@ViewAction(for: AppFeature.self)
struct AppView: View {
    @State var store: StoreOf<AppFeature>
    
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
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


#Preview {
    AppView(
        store: .init(initialState: AppFeature.State()) {
            AppFeature()
        }
    )
}
