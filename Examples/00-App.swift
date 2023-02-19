import ComposableArchitecture
import SwiftUI

@main
struct ExamplesApp: App {
  
  /// A property wrapper type that you use to create a UIKit app delegate.
  /// https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  /// The system moves your app’s Scene instances through phases that reflect a scene’s operational state.
  /// Read the current phase by observing the scenePhase value in the Environment:
  /// https://developer.apple.com/documentation/swiftui/scenephase
  @Environment(\.scenePhase) private var scenePhase

  init() {}

  var body: some Scene {
    WindowGroup {
      AppView(store: self.appDelegate.store)
    }
    .onChange(of: self.scenePhase) {
      self.appDelegate.viewStore.send(.didChangeScenePhase($0))
    }
  }
}
