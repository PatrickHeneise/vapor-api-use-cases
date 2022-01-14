import Fluent
import Vapor

struct DetailController {
  func list(req: Request) throws -> EventLoopFuture<[Detail]> {
    return Detail.query(on: req.db).all()
  }
}
