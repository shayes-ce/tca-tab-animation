import ComposableArchitecture
import Foundation

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var selectedTab: Tab = .one
    }
    
    enum Action: Equatable, BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
        
        enum View {
            case someButtonTapped
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding: return .none
                
            case let .view(viewAction):
                switch viewAction {
                case .someButtonTapped:
                    // do something
                    return .none
                }
            }
        }
    }
}
