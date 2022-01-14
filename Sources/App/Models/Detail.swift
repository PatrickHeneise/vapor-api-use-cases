import Fluent
import Vapor

final class Detail: Model, Content {
  static let schema = "details"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "description")
  var description: String

  @OptionalField(key: "date")
  var date: String?

  @Parent(key: "todo")
  var todo: Todo

  init() {}

  init(id: UUID? = nil, description: String) {
    self.id = id
    self.description = description
  }
}
