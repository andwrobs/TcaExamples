import ComposableArchitecture
import Foundation
import SQLite

// MARK: +-+-+ DEPENDENCY +-+-+

public struct ComposableSQLite {
  public var db: @Sendable (String) throws -> Connection
  
  public init(
    db: @escaping @Sendable (String) throws -> Connection
  ){
    self.db = db
  }
}
