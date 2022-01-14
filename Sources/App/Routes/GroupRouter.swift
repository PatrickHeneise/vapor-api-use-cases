import Fluent
import Vapor

struct GroupRouter: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let groupController = GroupController()

    let groups = routes.grouped("groups")
    groups.get(use: groupController.list)
  }
}
