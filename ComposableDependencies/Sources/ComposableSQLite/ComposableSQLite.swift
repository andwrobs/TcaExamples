import ComposableArchitecture
import Foundation

// MARK: +-+-+ ADD DEPENDENCY +-+-+

public extension DependencyValues {
  var sqlite: ComposableSQLite {
    get { self[ComposableSQLite.self] }
    set { self[ComposableSQLite.self] = newValue }
  }
}

// MARK: +-+-+ NOTES +-+-+

private let notes = """
  Tiny TCA wrapper around https://github.com/stephencelis/SQLite.swift
"""
