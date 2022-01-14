import Fluent

struct CreateTodo: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("todos")
      .id()
      .field("title", .string, .required)
      .field("assignee", .string, .required)
      .field("group", .string, .required)
      .field("done", .bool, .required)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("todos").delete()
  }
}
