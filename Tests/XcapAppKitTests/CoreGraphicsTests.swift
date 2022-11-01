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
    
    // MAKR: - CGPoint
    
    func testCGPoint_mid() {
        let p1 = CGPoint(x: 0, y: 0)
        let p2 = CGPoint(x: 10, y: 0)
        XCTAssertEqual(p1.mid(with: p2), CGPoint(x: 5, y: 0))
    }
    
    func testCGPoint_distance() {
        let p1 = CGPoint(x: 0, y: 0)
        let p2 = CGPoint(x: 10, y: 0)
        XCTAssertEqual(p1.distance(with: p2), 10)
    }
    
    func testCGPoint_extended() {
        let p = CGPoint(x: 0, y: 0)
        let extended = p.extended(length: 10, angle: .pi / 2)
        XCTAssertLessThan(extended.x, 1e-5)
        XCTAssertEqual(extended.y, 10)
    }
    
}
