import XCTest
@testable import Interview

final class ListContactsViewControllerTests: XCTest {
    
    private let sut: ListContactsViewController! = nil
    
    func test_didLoad() {
        sut.viewDidLoad()
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.title, "Lista de contatos")
    }
    
}
