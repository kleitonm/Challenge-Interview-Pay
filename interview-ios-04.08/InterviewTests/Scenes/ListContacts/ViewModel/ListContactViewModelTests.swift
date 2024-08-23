import XCTest
@testable import Interview

final class ListContactViewModelTests: XCTestCase {

    func test_fetchContacts_failure() {
        let (sut, spy) = makeSut()
        let exp = expectation(description: "Fetch Data Failure")
        let error: NSError = .init(domain: "failure", code: 400)
        var expectation: Error?
        
        spy.expectation = .failure(error)
        
        sut.loadContacts(completion: { result in
            if case .failure(let error) = result {
                expectation = error
            }
            exp.fulfill()
        })
        wait(for: [exp], timeout: 5.0)
        XCTAssertNotNil(expectation)
    }
    
    func test_fetchContacts_success() {
        let (sut, spy) = makeSut()
        let exp = expectation(description: "Fetch Data Success")
        var data: [Contact]?
        
        spy.expectation = .success([.fixture()])
        
        sut.loadContacts(completion: { result in
            if case .success(let contact) = result {
                data = contact
            }
            exp.fulfill()
        })
        wait(for: [exp], timeout: 5.0)
        XCTAssertNotNil(data)
    }
}

extension ListContactViewModelTests {
    private func makeSut() -> (sut:  ListContactsViewModel, spy: ListContactsViewModelSpy) {
        
        let spy = ListContactsViewModelSpy()
        let sut =  ListContactsViewModel(service: spy)
        return (sut, spy)
    }
}
