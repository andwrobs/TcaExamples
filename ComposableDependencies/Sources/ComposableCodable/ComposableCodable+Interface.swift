import ComposableArchitecture
import Foundation

// MARK: +-+-+ COMPOSABLE DECODE +-+-+

public struct ComposableDecoder {
  public var decode: @Sendable (any Decodable.Type, Data) throws -> any Decodable
  
  public init(
    decode: @escaping @Sendable (any Decodable.Type, Data) throws -> any Decodable
  ){
    self.decode = decode
  }
}

// MARK: +-+-+ COMPOSABLE ENCODE +-+-+

public struct ComposableEncoder {
  public var encode: @Sendable (any Encodable) throws -> Data
  
  public init(
    encode: @escaping @Sendable (any Encodable) throws -> Data
  ) {
    self.encode = encode
  }
}
