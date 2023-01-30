import ComposableArchitecture
import SwiftUI

/// contains core shared logic & the state for all children examples/demos
struct Root: ReducerProtocol {
  
  struct State: Equatable {
    var localDatabaseCounterDemo = LocalDatabaseCounterDemo.State()
  }
  
  enum Action {
    case localDatabaseCounterDemo(LocalDatabaseCounterDemo.Action)
    case onAppear
  }

  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state = .init()
        return .none

      default:
        return .none
      }
    }

    Scope(state: \.localDatabaseCounterDemo, action: /Action.localDatabaseCounterDemo) {
      LocalDatabaseCounterDemo()
        .dependency(\.localDbClient, .autoMigratingLive())
    }
  }
  
}

struct RootView: View {
  let store: StoreOf<Root>
  
  var body: some View {
    NavigationView {
      Form {
        /// local database section
        Section(header: Text("Local Database Demos")) {
          ///
          NavigationLink(
            "Local Database Counter Demo",
            destination: LocalDatabaseCounterDemoView(
              store: self.store.scope(
                state: \.localDatabaseCounterDemo,
                action: Root.Action.localDatabaseCounterDemo
              )
            )
          )
        }
      }
    }
    
  }
}
