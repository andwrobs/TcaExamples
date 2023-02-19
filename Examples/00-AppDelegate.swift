import ComposableArchitecture
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: AppRoot.State(),
    reducer: AppRoot()
  )

  var viewStore: ViewStore<Void, AppRoot.Action> {
    ViewStore(self.store.stateless)
  }

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    self.viewStore.send(.appDelegate(.didFinishLaunching))
    return true
  }

  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    self.viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.success(deviceToken))))
  }

  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    self.viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.failure(error))))
  }
}
