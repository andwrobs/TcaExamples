import ComposableArchitecture
import Foundation

// MARK: +-+-+ ADD DEPENDENCIES +-+-+

public extension DependencyValues {
  var decoder: ComposableDecoder {
    get { self[ComposableDecoder.self] }
    set { self[ComposableDecoder.self] = newValue }
  }
}

public extension DependencyValues {
  var encoder: ComposableEncoder {
    get { self[ComposableEncoder.self] }
    set { self[ComposableEncoder.self] = newValue }
  }
}

// MARK: +-+-+ NOTES +-+-+

private let notes = """

- Inspired by:
https://github.com/tgrapperon/swift-dependencies-additions

"""
