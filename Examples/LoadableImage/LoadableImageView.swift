import ComposableArchitecture
import SwiftUI

public struct LoadableImageView: View {
  
  let store: StoreOf<LoadableImage>
  
  public var body: some View {
    Group {
      Text("image")
     }
     .task {
         await print("hello")
     }
  }
  
}
