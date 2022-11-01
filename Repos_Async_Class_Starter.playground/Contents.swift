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

/** basic try-catch
do {
  let res = try somemethod()
} catch {

}
 */

/**
 define error
 enum EncryptionError: Error {
   case empty
   case short
 }
 // in somemethod
 guard password.count >= 5 else {
   throw EncryptionError.short
 }
// in main method
 catch EncryptionError.empty {
   print("....")
 }
 */

// A task to utilize this function
// - call function then loop over repos array to print out the name & url for each
// - interject lots of print statements with 'Step X' to see how things are progressing
Task {
  print("Step 1")
  print("Start task")
  // fetch data
  do {
    let data = try await fetchRepositories();
    // print data
    print("Step 2")
    print(data)
    // finish the task
    print("End task")
    print("Step 5")
  } catch {
    print("Error")
  }
  
}
print("Step 6")
