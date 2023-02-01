import ComposableArchitecture
import Foundation

// MARK: +-+-+ DEPENDENCY +-+-+

public struct ComposableAppContext {
  public var documentsDirectoryPath: @Sendable () -> String
  
  public init(
    documentsDirectoryPath: @escaping @Sendable () -> String
  ){
    self.documentsDirectoryPath = documentsDirectoryPath
  }
}
