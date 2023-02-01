import ComposableArchitecture
import Foundation

// MARK: +-+-+ ADD DEPENDENCY +-+-+

public extension DependencyValues {
  var appContext: ComposableAppContext {
    get { self[ComposableAppContext.self] }
    set { self[ComposableAppContext.self] = newValue }
  }
}

// MARK: +-+-+ NOTES +-+-+

private let notes = """
  This dependency exposes app context information.
"""
