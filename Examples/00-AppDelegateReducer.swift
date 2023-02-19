import ComposableArchitecture
import Foundation

public struct AppDelegateReducer: ReducerProtocol {
  
  public struct State: Equatable {
    public var logs: [String] = []
  }
  
  public enum Action: Equatable {
    case didFinishLaunching
    case didRegisterForRemoteNotifications(TaskResult<Data>)
  }
  
  public init() {}
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .didFinishLaunching:
      return .fireAndForget {
        print(".didFinishLaunching")
      }
      
    case .didRegisterForRemoteNotifications(.failure):
      return .fireAndForget {
        print(".didRegisterForRemoteNotifications(.failure)")
      }
      
    case let .didRegisterForRemoteNotifications(.success(tokenData)):
      let token = tokenData.map { String(format: "%02.2hhx", $0) }.joined()
      return .fireAndForget {
        print(".didRegisterForRemoteNotifications(.success(tokenData)): \(token)")
      }
    }
  }
  
}
