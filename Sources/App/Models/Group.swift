import Fluent
import Vapor

final class Group: Model, Content {
  static let schema = "groups"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "title")
  var title: String

  @Children(for: \.$group)
  var todos: [Todo]

  init() {}

  init(id: UUID? = nil, title: String) {
    self.id = id
    self.title = title
  }
}
