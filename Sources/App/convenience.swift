import Vapor

protocol ApiModel {
  associatedtype Response: Content
  
  var toPublic: Response { get }
}

extension Array where Element: ApiModel {
  var mapToPublic: [Element.Response] {
    map { $0.toPublic }
  }
}
