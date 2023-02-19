import ComposableArchitecture
import UIKit

// MARK: +-+-+ DEPENDENCY +-+-+

public struct ComposableBackgroundTask {
  public let begin: @Sendable @MainActor (String?) -> UIBackgroundTaskIdentifier
  public let end: @Sendable @MainActor (UIBackgroundTaskIdentifier) -> Void
  
  public init(
    begin: @escaping @Sendable @MainActor (String?) -> UIBackgroundTaskIdentifier,
    end: @escaping @Sendable @MainActor (UIBackgroundTaskIdentifier) -> Void
  ){
    self.begin = begin
    self.end = end
  }
}
