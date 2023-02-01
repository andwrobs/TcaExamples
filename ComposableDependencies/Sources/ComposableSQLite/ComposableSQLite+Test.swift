import ComposableArchitecture
import Foundation
import SQLite
import XCTestDynamicOverlay

// MARK: +-+-+ TEST KEYS +-+-+

extension ComposableSQLite: TestDependencyKey {
  
  public static let testValue = Self(
    db: XCTUnimplemented("\(Self.self).migrate")
  )
  
}
