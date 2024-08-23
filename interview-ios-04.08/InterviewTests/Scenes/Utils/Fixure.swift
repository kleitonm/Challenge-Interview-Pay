import Foundation
@testable import Interview

extension Contact {
    static func fixture(id: Int = 10, name: String = "Lebron James", photoURL: String = "Image") -> Self {
        .init(id: id, name: name, photoURL: photoURL)
    }
}

struct Person {
    let name: String
    let dog: Dog
}

extension Person {
    static func fixture(name: String = "", dog: Dog = .fixtureDog()) -> Self  {
        .init(name: name, dog: dog)
    }
}

struct Dog {
    let name: String
}

extension Dog {
    static func fixtureDog(name: String = "") -> Self  {
        .init(name: name)
    }
}
