import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get { req in
    return "It works!"
  }

  try app.register(collection: GroupRouter())
  try app.register(collection: UserRouter())
  try app.register(collection: TodoRouter())
  try app.register(collection: DetailRouter())
}
