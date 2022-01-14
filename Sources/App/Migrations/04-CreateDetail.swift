import Fluent

struct CreateDetail: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("details")
      .id()
      .field("description", .string, .required)
      .field("date", .string)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("details").delete()
  }
}
