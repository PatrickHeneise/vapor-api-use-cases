import Fluent

struct CreateGroup: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("groups")
      .id()
      .field("title", .string, .required)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("groups").delete()
  }
}
