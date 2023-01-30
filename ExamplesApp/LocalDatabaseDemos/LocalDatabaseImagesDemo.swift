import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: +-+-+ REDUCER +-+-+

struct LocalDatabaseImagesDemo: ReducerProtocol {
  
  struct State: Equatable {
    var count: Int = 0
  }
  
  enum Action {
    case increment
    case decrement
  }
  
  @Dependency(\.date.now) var date_NOW
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .increment:
        return .none
      case .decrement:
        return .none
      }
    }
  }
}

// MARK: +-+-+ VIEW +-+-+

struct LocalDatabaseImagesDemoView: View {
  var body: some View {
    Text("Images Demo")
  }
}

// MARK: +-+-+ TYPES +-+-+

//extension UIImage: Value {
//    public class var declaredDatatype: String {
//        return Blob.declaredDatatype
//    }
//    public class func fromDatatypeValue(blobValue: Blob) -> UIImage {
//        return UIImage(data: Data.fromDatatypeValue(blobValue))!
//    }
//    public var datatypeValue: Blob {
//        return UIImagePNGRepresentation(self)!.datatypeValue
//    }
//
//}
