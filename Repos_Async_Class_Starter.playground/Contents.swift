import SwiftUI
import Foundation
// let multiply = {(a: Int, b: int) -> Int in a * b}
// Simplified decodable structs from earlier exercise
struct Repositories: Decodable {
  let repos: [Repository]

  enum CodingKeys : String, CodingKey {
    case repos = "items"
  }
}

struct Repository: Decodable {
  let name: String
  let htmlURL: String

  enum CodingKeys : String, CodingKey {
    case name
    case htmlURL = "html_url"
  }
}

// Our initial function (needs fixing...)
func fetchRepositories() async throws -> [Repository] {
  let url = URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc")!
  let (data, _) = try await URLSession.shared.data(from: url)
  return try await JSONDecoder().decode(Repositories.self, from: data).repos
}

// A task to utilize this function
// - call function then loop over repos array to print out the name & url for each
// - interject lots of print statements with 'Step X' to see how things are progressing
Task {
  print("Step 1 Task Start")
  // fetch data
  do {
    print("Step 2 Fetch Data")
    let data = try await fetchRepositories();
    // print data
    print("Step 3 Print Data")
    for repo in data {
      print("\(repo.name): \(repo.htmlURL)")
    }
    
  } catch {
    print("Error")
  }
  print("Step 4 End task")
}
print("Step 5 Outside")
