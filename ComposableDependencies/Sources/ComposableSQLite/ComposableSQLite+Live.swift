import ComposableArchitecture
import Foundation
import SQLite

// MARK: +-+-+ LIVE +-+-+

extension ComposableSQLite: DependencyKey {
  
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    
    return ComposableSQLite(
      db: {
        /// uncaught error if unable to establish connection to app's sqlite db file, this is intentional for nowl
        try! Connection("\($0)/db.sqlite3")
      }
    )
  }
  
}


// MARK: +-+-+ NOTES +-+-+

private let notes = """

REFERENCE DOCS

///

SQLite.swift

- Read-Write Databases
https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#read-write-databases

///

swift-dependencies

- Designing dependencies
https://pointfreeco.github.io/swift-dependencies/main/documentation/dependencies/designingdependencies
  
- Dependency lifetimes
https://pointfreeco.github.io/swift-dependencies/main/documentation/dependencies/lifetimes

"""
