//
//  File.swift
import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay

// MARK: +-+-+ TEST KEYS +-+-+

extension ComposableBackgroundTask: TestDependencyKey {

  public static var previewValue: ComposableBackgroundTask {
    liveValue
  }
  
  public static let testValue = Self(
    begin: unimplemented("\(Self.self).begin"),
    end: unimplemented("\(Self.self).end")
  )

}
