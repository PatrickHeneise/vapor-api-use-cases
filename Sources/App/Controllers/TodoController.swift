import Fluent
import Vapor

struct TodoController {
  func list(req: Request) throws -> EventLoopFuture<Page<TodoListObject>> {
    return
      Todo
      .query(on: req.db)
      .with(\.$group)
      .join(Group.self, on: \Todo.$group.$id == \Group.$id)
      .paginate(for: req).map { $0.map { $0.mapList() } }
  }

  func create(req: Request) throws -> EventLoopFuture<TodoGetObject> {
    let todo = try req.content.decode(Todo.self)
    return todo.save(on: req.db).map { todo.mapGet() }
  }
}
