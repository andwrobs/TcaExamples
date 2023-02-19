import ComposableArchitecture

// MARK: +-+-+ ADD DEPENDENCY +-+-+

extension DependencyValues {
  public var backgroundTask: ComposableBackgroundTask {
    get { self[ComposableBackgroundTask.self] }
    set { self[ComposableBackgroundTask.self] = newValue }
  }
}
