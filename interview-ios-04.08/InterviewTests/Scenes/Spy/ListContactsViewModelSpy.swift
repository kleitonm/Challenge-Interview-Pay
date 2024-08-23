import XCTest
@testable import Interview

final class ListContactsViewModelSpy: ListContactServiceProtocol {
    
    var expectation: (Result<[Interview.Contact], any Error>)?
    
    func fetchContacts(completion: @escaping (Result<[Interview.Contact], any Error>) -> Void) {
        if let expectation {
            completion(expectation)
        }
    }
    
}

