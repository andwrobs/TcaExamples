import ComposableArchitecture
import SwiftUI

public struct AppView: View {
  let store: StoreOf<AppRoot>
  
  public var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Examples")) {
          
          NavigationLink(
            "Local Database",
            destination: LocalDatabaseCounterDemoView(
              store: self.store.scope(
                state: \.localDatabaseCounterDemo,
                action: AppRoot.Action.localDatabaseCounterDemo
              )
            )
          )
          
          NavigationLink(
            "Loadable Image",
            destination: LocalDatabaseCounterDemoView(
              store: self.store.scope(
                state: \.localDatabaseCounterDemo,
                action: AppRoot.Action.localDatabaseCounterDemo
              )
            )
          )
        }
      }
    }
    
  }
}
