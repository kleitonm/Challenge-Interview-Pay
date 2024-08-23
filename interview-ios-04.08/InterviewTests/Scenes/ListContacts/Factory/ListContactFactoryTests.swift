import XCTest
@testable import Interview

final class ListContactsFactoryTests: XCTest {
    
    func test_factory() {
        let factory = ListContactsFactory.make()
        XCTAssertNotNil(factory)
    }
}
