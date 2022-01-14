import Fluent
import Vapor

struct UserRouter: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let userController = UserController()

    let users = routes.grouped("users")
    users.get(use: userController.list)
  }
}
