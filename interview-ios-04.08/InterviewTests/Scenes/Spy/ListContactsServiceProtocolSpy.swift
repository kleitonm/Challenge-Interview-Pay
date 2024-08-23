@testable import Interview

final class ListContactsServiceProtocolSpy: ListContactServiceProtocol {
    
    var expectation: (Result<[Contact], any Error>)? = nil
    
    func fetchContacts(completion: @escaping (Result<[Contact], any Error>) -> Void) {
        if let expectation {
            completion(expectation)
        }
    }
}
