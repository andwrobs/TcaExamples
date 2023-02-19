import ComposableArchitecture
import Foundation

public struct LoadableImage: ReducerProtocol {
  
  public struct State: Equatable {
  
  }
  
  public enum Action: Equatable {
    case loading
    case loaded
    case error
  }
  
  // @Dependency(\.mediaClient) var mediaClient: MediaClient
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }
  
}
