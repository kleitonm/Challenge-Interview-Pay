import XCTest
@testable import Interview

final class ListContactServiceTests: XCTestCase {

//    func test_fetchContacts_failure() {
//        let sut = makeSut()
//        let exp = expectation(description: "Fetch Data Failure")
//        let error: NSError = .init(domain: "failure", code: 400)
//        
//
//        spy.expectation = .failure(error)
//        
//        sut.fetchContacts { result in
//            if case .failure(let dataModel) = result {
//                XCTAssertNotNil(dataModel)
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 5.0)
//    }
    
    func test_fetchContacts_success() {
        let sut = makeSut()
        let exp = expectation(description: "Fetch Data Success")
        var data = Contact.fixture()
        var expected: Result<[Contact], Error>?
     
        
        sut.fetchContacts { result in
            if case .success(let dataModel) = result {
                expected = result
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        XCTAssertNotNil(expected)
    }
}


var mockData: Data? {
    """
    [{
      "id": 2,
      "name": "Beyonce",
      "photoURL": "https://api.adorable.io/avatars/285/a2.png"
    }]
    """.data(using: .utf8)
}

extension ListContactServiceTests {
    private func makeSut() -> ListContactService {
        
        let sut = ListContactService(session: .shared)
        return sut
    }
}


