import ComposableArchitecture
import SwiftUI

// MARK: +-+-+ REDUCER +-+-+

struct LocalDatabaseCounterDemo: ReducerProtocol {
  
  struct State: Equatable {
    var count: Int = 0
    var countRecords: [CountRecord] = []
  }
  
  enum Action {
    case increment
    case decrement
    case selectTapped
    case selectResponse(TaskResult<[CountRecord]>)
    case wipe
  }
  
  @Dependency(\.date.now) var date_NOW
  @Dependency(\.uuid) var uuid
  @Dependency(\.localDbClient) var localDbClient
  
  private enum CancelID {}
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .increment:
        return .fireAndForget { [count = state.count] in
          _ = try await localDbClient.insertCountRecords(
            [
              .init(uuid: uuid(), count: count + 1, context: .init(insertedAt: date_NOW)), 
            ]
          )
        }
        
      case .decrement:
        return .none
        
      case .selectTapped:
        return .task {
          await .selectResponse(
            TaskResult {
              try await localDbClient.allCountRecords()
            }
          )
        }
        .cancellable(id: CancelID.self, cancelInFlight: true)
        
      case .selectResponse(.success(let countRecords)):
        state.countRecords = countRecords
        return .none
        
      case .selectResponse(.failure(let error)):
        print(error)
        return .none
        
        
      case .wipe:
        return .none
      }
    }
  }
}

// MARK: +-+-+ VIEW +-+-+

struct LocalDatabaseCounterDemoView: View {
  let store: StoreOf<LocalDatabaseCounterDemo>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("Counter Demo")
      
      Button("Increment") { viewStore.send(.increment) }
      Button("Decrement") { viewStore.send(.decrement) }

      Button("Select *") { viewStore.send(.selectTapped) }
      
      VStack {
        ForEach(viewStore.countRecords) { countRecord in
          Text(countRecord.uuid.uuidString)
        }
      }
    }
    
    
  }
}
