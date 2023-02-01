import ComposableArchitecture
import Foundation

// MARK: +-+-+ LIVE +-+-+

extension ComposableAppContext: DependencyKey {
  
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
  
    return ComposableAppContext(
      
      documentsDirectoryPath: {
        /// returns the path to the app’s Documents directory
        NSSearchPathForDirectoriesInDomains(
          .documentDirectory, .userDomainMask, true
        ).first!
      }
      
    )
    
  }
  
}
