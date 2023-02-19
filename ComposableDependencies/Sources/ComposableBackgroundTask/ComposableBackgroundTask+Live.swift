import ComposableArchitecture
import UIKit

// MARK: +-+-+ LIVE +-+-+

extension ComposableBackgroundTask: DependencyKey {
  
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    return ComposableBackgroundTask(
      begin: {
        UIApplication.shared.beginBackgroundTask(withName: $0)
      },
      end: {
        UIApplication.shared.endBackgroundTask($0)
      }
    )
  }
  
}
