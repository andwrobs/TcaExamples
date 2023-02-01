import ComposableArchitecture
import Foundation

// MARK: +-+-+ LIVE DECODE DEPENDENCY +-+-+

extension ComposableDecoder: DependencyKey {
  
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    /// 1 - initialize a json decoder
    let decoder: JSONDecoder = JSONDecoder()
    /// 2 - implement live value using the json decoder instance scoped to this closure
    return ComposableDecoder(
      decode: {
        try decoder.decode($0, from: $1)
      }
    )
  }
  
}

// MARK: +-+-+ LIVE ENCODE DEPENDENCY +-+-+

extension ComposableEncoder: DependencyKey {
  
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    /// 1 - initialize a json encoder & configure output formatting to help with testing
    let encoder: JSONEncoder = JSONEncoder()
    encoder.outputFormatting.insert(.sortedKeys)
    /// 2 - implement live value using the json encoder instance scoped to this closure
    return ComposableEncoder(
      encode: {
        try encoder.encode($0)
      }
    )
  }
  
}
