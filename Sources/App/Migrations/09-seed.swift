import FluentKit
import Foundation

struct SeedSampleData: AsyncMigration {
  func prepare(on database: Database) async throws {

    let users: [User] = [
      .init(firstName: "Jane", lastName: "Doe"),
      .init(firstName: "John", lastName: "Doe"),
    ]
    await withTaskGroup(of: Void.self) { taskGroup in
      users.forEach { model in
        taskGroup.addTask {
          do {
            try await model.create(on: database)
          } catch let error {
            print("create failed", model, error)
          }
        }
      }
    }

    let groups: [Group] = [
      .init(title: "Family"),
      .init(title: "Car"),
    ]
    await withTaskGroup(of: Void.self) { taskGroup in
      groups.forEach { model in
        taskGroup.addTask {
          do {
            try await model.create(on: database)
          } catch let error {
            print("create failed", model, error)
          }
        }
      }
    }

    let todos: [Todo] = [
      try .init(title: "Change oil", group: groups[1], assignee: users[0]),
      try .init(title: "Shopping", group: groups[0], assignee: users[1]),
      try .init(title: "Mealplan", group: groups[0], assignee: users[0]),
    ]
    await withTaskGroup(of: Void.self) { taskGroup in
      todos.forEach { model in
        taskGroup.addTask {
          do {
            try await model.create(on: database)
          } catch let error {
            print("create failed", model, error)
          }
        }
      }
    }
  }

  func revert(on database: Database) async throws {}
}
