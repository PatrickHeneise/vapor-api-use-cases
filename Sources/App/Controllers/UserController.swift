import Fluent
import Vapor

struct UserController {
  func list(req: Request) throws -> EventLoopFuture<[User]> {
    return
      User
      .query(on: req.db)
      .all()
  }

  func create(req: Request) throws -> EventLoopFuture<User> {
    let user = try req.content.decode(User.self)
    return user.save(on: req.db).map { user }
  }
}
