import Fluent
import Vapor

struct TodoGetObject: Content {
  let id: UUID
  let title:String
}

struct TodoListObject: Content {
  let id: UUID?

  let title: String
  let group: String
  let subtitle: String

  init(with domainObject: Todo) {
    self.id = domainObject.id
    self.title = domainObject.title
    
    // Nested property example
    self.group = domainObject.group.title
    
    // Computed property example
    self.subtitle = "\(domainObject.title) in \(domainObject.group.title)"
  }
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

extension Todo: ApiModel {
  var toPublic: TodoListObject {
    return .init(with: self)
  }
}

extension Todo {
  func mapGet() -> TodoGetObject {
    .init(id: id!, title: title)
  }
}
