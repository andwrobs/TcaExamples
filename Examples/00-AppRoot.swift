import ComposableArchitecture
import SwiftUI

public struct AppRoot: ReducerProtocol {
  
  public struct State: Equatable {
    public var appSettings = AppDelegateReducer.State()
    public var localDatabaseCounterDemo = LocalDatabaseCounterDemo.State()
  }
  
  public enum Action {
    case appDelegate(AppDelegateReducer.Action)
    case didChangeScenePhase(ScenePhase)
    case localDatabaseCounterDemo(LocalDatabaseCounterDemo.Action)
  }
  
  @Dependency(\.mainQueue) var mainQueue

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.appSettings, action: /Action.appDelegate) {
      AppDelegateReducer()
    }
    
    Scope(state: \.localDatabaseCounterDemo, action: /Action.localDatabaseCounterDemo) {
      LocalDatabaseCounterDemo()
        .dependency(\.localDbClient, .autoMigratingLive())
    }
    
    Reduce { state, action in
      switch action {
        
      case let .didChangeScenePhase(newPhase):
        switch newPhase {
        case .active:
          print(".didChangeScenePhase(.active)")
          return .none
          
        case .inactive:
          print(".didChangeScenePhase(.inactive)")
          return .none
          
        case .background:
          print(".didChangeScenePhase(.background)")
          return .run { send in
            print("background alive 1 sec later")
            try await mainQueue.sleep(for: .milliseconds(500))
            print("background alive 2 sec later")
          }
          
        @unknown default:
          return .none
        }
        
      default:
        return .none
      }
    }
    
  }
  
}
