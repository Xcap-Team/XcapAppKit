#if os(macOS)

import XCTest

@testable import XcapAppKit

class AppKitTests: XCTestCase {
    
    func testUIColor_initWithValue() {
        let color = CIColor(color: NSColor(value: 0x3366CC))
        
        XCTAssertEqual(color?.red, 0.2)
        XCTAssertEqual(color?.green, 0.4)
        XCTAssertEqual(color?.blue, 0.8)
    }
    
}

#endif
