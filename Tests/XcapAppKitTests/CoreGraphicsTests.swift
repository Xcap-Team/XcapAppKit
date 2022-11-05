import XCTest
@testable import XcapAppKit

final class CoreGraphicsTests: XCTestCase {
    
    // MARK: - CGFloat
    
    func testCGFloat_rounded() {
        XCTAssertEqual(CGFloat(5.123456).rounded(to: 4), 5.1235)
        XCTAssertEqual(CGFloat(5.123456).rounded(to: 3, rule: .down), 5.123)
        XCTAssertEqual(CGFloat(5.123456).rounded(to: 2, rule: .up), 5.13)
    }
    
    func testCGFloat_clean() {
        XCTAssertEqual(CGFloat(5.0).clean, "5")
    }
    
}
