import Fluent
import Vapor

struct TodoListObject: Content {
  let id: UUID?

  let title: String
  let group: Group

  var subtitle: String {
    return "\(title) in \(group)"
  }

  init(with domainObject: Todo) {
    self.title = domainObject.title
    self.group = domainObject.group
    self.id = domainObject.id
  }
}

struct TodoGetObject: Content {
  let id: UUID
}

final class Todo: Model {
  static let schema = "todos"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "title")
  var title: String

  @Field(key: "done")
  var done: Bool

  @Parent(key: "group")
  var group: Group

  @Parent(key: "assignee")
  var assignee: User

  @OptionalChild(for: \.$todo)
  var detail: Detail?

  init() {}

  init(id: UUID? = nil, title: String, group: Group.IDValue, assignee: User.IDValue) {
    self.id = id
    self.done = false
    self.$group.id = group
    self.$assignee.id = assignee
    self.title = title
  }

  convenience init(title: String, group: Group, assignee: User) throws {
    self.init(
      title: title,
      group: try group.requireID(),
      assignee: try assignee.requireID()
    )
  }
}

extension Todo: ResponseConvertible {
  func mapGet() -> TodoGetObject {
    .init(id: id!)
  }

  var mapToPublic: TodoListObject {
    return .init(with: self)
  }
}
