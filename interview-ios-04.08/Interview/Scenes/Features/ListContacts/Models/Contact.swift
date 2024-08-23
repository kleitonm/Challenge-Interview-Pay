import Foundation

/*
 Json Contract
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://picsum.photos/id/237/200/"
  }
]
*/

struct Contact: Codable, Equatable {
    var id: Int
    var name: String
    var photoURL: String
}
