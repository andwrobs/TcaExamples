import ComposableArchitecture
import ComposableAppContext
import ComposableCodable
import ComposableSQLite
import Foundation
import SQLite

// MARK: +-+-+ INTERFACE +-+-+

public struct LocalDatabaseClient {
  public var allCountRecords: @Sendable () async throws -> [CountRecord]
  public var insertCountRecords: @Sendable ([CountRecord]) async throws -> Int
  public var migrate: @Sendable () async throws -> Void
  
  public init(
    allCountRecords: @escaping @Sendable () async throws -> [CountRecord],
    insertCountRecords: @escaping @Sendable ([CountRecord]) async throws -> Int,
    migrate: @escaping @Sendable () async throws -> Void
  ) {
    self.allCountRecords = allCountRecords
    self.insertCountRecords = insertCountRecords
    self.migrate = migrate
  }
}

// MARK: +-+-+ LIVE +-+-+

extension LocalDatabaseClient: DependencyKey {
  
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    @Dependency(\.appContext) var appContext: ComposableAppContext
    @Dependency(\.decoder) var decoder: ComposableDecoder
    @Dependency(\.encoder) var encoder: ComposableEncoder
    @Dependency(\.sqlite) var sqlite: ComposableSQLite
    
    let db = try! sqlite.db(appContext.documentsDirectoryPath())
    
    /// 2 - implement client handlers using local closure scoped sqlite connection instance
    return LocalDatabaseClient(
      
      allCountRecords: {
        /// convert results into an array of rows
        var countRecords: [CountRecord] = []
        let rowIterator = try db.prepareRowIterator(Db.CountRecordsTable._self)
        for countRecordAsRow in try Array(rowIterator) {
          /// 1 - pluck data property from
          let countRecordAsData = Data.fromDatatypeValue(countRecordAsRow[Db.CountRecordsTable.data])
          /// 2 - attempt to decode
          let countRecord = try decoder.decode(
            CountRecord.self, countRecordAsData
          ) as! CountRecord
          /// 3 - append to count records
          countRecords.append(countRecord)
        }
        return countRecords
      },
      
      insertCountRecords: { countRecords in
        /// form per-row setters from array of count records
        let rowSetters: [[Setter]] = try countRecords.map {
          [
            Db.CountRecordsTable.uuid <- $0.uuid,
            Db.CountRecordsTable.data <- try encoder.encode($0).datatypeValue
          ]
        }
        /// try to insert
        let lastRowId = try db.run(Db.CountRecordsTable._self.insertMany(rowSetters))
        /// cast Int64 to Swift Int
        return Int(truncatingIfNeeded: lastRowId)
      },
      
      migrate: {
        /// attempt to create the count records table
        try db.run(Db.CountRecordsTable._self.create(ifNotExists: true) { t in
          t.column(Db.CountRecordsTable._id, primaryKey: .autoincrement)
          t.column(Db.CountRecordsTable.uuid)
          t.column(Db.CountRecordsTable.data)
        })
      }
      
    )
    
  }
  
  public static func autoMigratingLive() -> Self {
    let client = Self.live()
    Task { try await client.migrate() }
    return client
  }
  
}

// MARK: +-+-+ TEST KEYS +-+-+

extension LocalDatabaseClient: TestDependencyKey {
  
  public static let testValue = Self(
    allCountRecords: XCTUnimplemented("\(Self.self).allCountRecords"),
    insertCountRecords: XCTUnimplemented("\(Self.self).insertCountRecords"),
    migrate: XCTUnimplemented("\(Self.self).migrate")
  )
  
}

// MARK: +-+-+ ADD DEPENDENCY +-+-+

extension DependencyValues {
  var localDbClient: LocalDatabaseClient {
    get { self[LocalDatabaseClient.self] }
    set { self[LocalDatabaseClient.self] = newValue }
  }
}

// MARK: +-+-+ LOCAL DATABASE SCHEMA +-+-+

public struct Db {
  
  struct CountRecordsTable {
    static let _self = Table("count_records")
    static let _id = Expression<Int64>("_id")
    static let uuid = Expression<UUID>("uuid")
    static let data = Expression<Blob>("data")
  }
  
  /// todo: version for migrations?
}

// MARK: +-+-+ MODELS +-+-+

public struct CountRecord: Equatable, Codable, Identifiable {
  public var uuid: UUID
  public var count: Int
  public var context: CountContext
  
  public var id: String { uuid.uuidString }
}

public struct CountContext: Equatable, Codable {
  public var insertedAt: Date
}

// MARK: +-+-+ NOTES +-+-+

private let notes = """
- Building queries
https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#building-complex-queries

- Failable iteration
https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#failable-iteration

- Truncating Integer constructor
https://stackoverflow.com/questions/32793460/can-i-cast-int64-directly-into-int
"""
