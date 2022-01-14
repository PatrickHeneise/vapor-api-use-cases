import Fluent
import Vapor

struct TodoRouter: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let todoController = TodoController()

    let todos = routes.grouped("todos")
    todos.get(use: todoController.list)
  }
}
