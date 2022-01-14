import Fluent
import Vapor

struct DetailRouter: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let detailController = DetailController()

    let details = routes.grouped("details")
    details.get(use: detailController.list)
  }
}
