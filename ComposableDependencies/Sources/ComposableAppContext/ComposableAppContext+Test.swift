import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay

// MARK: +-+-+ TEST KEYS +-+-+

extension ComposableAppContext: TestDependencyKey {
  
  public static let previewValue = Self.noop

  public static let testValue = Self(
    documentsDirectoryPath: XCTUnimplemented("\(Self.self).documentsDirectoryPath")
  )
  
}

// MARK: +-+-+ NOOP +-+-+

public extension ComposableAppContext {
  
  static let noop = Self(
    documentsDirectoryPath: { "" }
  )
  
}
