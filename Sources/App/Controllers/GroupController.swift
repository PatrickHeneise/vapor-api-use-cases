import Fluent
import Vapor

struct GroupController {
  func list(req: Request) throws -> EventLoopFuture<[Group]> {
    return Group.query(on: req.db).all()
  }

  func create(req: Request) throws -> EventLoopFuture<Group> {
    let group = try req.content.decode(Group.self)
    return group.save(on: req.db).map { group }
  }

  func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
    return Group.find(req.parameters.get("groupID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { $0.delete(on: req.db) }
      .transform(to: .ok)
  }
}
