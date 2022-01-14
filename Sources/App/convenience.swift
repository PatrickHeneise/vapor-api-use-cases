import Vapor

protocol ResponseConvertible {
  associatedtype Response: Content
  var mapToPublic: Response { get }
}

extension Array where Element: ResponseConvertible {
  var mapToPublic: [Element.Response] {
    map { $0.mapToPublic }
  }
}
