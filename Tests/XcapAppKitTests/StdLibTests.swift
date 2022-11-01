import XCTest
import SwiftUI
@testable import XcapAppKit

final class StdLibTests: XCTestCase {
    
    // MARK: - BinaryFloatingPoint
    
    func testBinaryFloatingPoint_rounded() {
        
        XCTAssertEqual(5.4.rounded(to: 0), 5)
        XCTAssertEqual(5.5.rounded(to: 0), 6)
        XCTAssertEqual(5.123456.rounded(to: 10), 5.123456)
        XCTAssertEqual(5.123456.rounded(to: 4), 5.1235)
        XCTAssertEqual(5.123456.rounded(to: 3, rule: .down), 5.123)
        XCTAssertEqual(5.123456.rounded(to: 2, rule: .up), 5.13)
    }
    
    func testBinaryFloatingPoint_clean() {
        XCTAssertEqual(5.0.clean, "5")
    }
    
    func testCollection_get() {
        let indexes = [0, 2]
        let indexSet = IndexSet(indexes)
        XCTAssertEqual([1, 2, 3].get(nil), nil)
        XCTAssertEqual([1, 2, 3].get(0), 1)
        XCTAssertEqual([1, 2, 3].get(2), 3)
        XCTAssertEqual([1, 2, 3].get(indexes), [1, 3])
        XCTAssertEqual([1, 2, 3].get(indexSet), [1, 3])
    }
    
    func testCollection_indexes() {
        let elements = ["1", "2"]
        let elementSet = Set(elements)
        
        XCTAssertEqual(["", "1", "", "2"].indexes(of: elements), [1, 3])
        XCTAssertEqual(["", "1", "", "2"].indexes(of: elementSet).sorted(by: <), [1, 3])
        
        XCTAssertEqual(["", "1", "", "2"].indexes(of: elements, where: { $0 == $1}), [1, 3])
        XCTAssertEqual(["", "1", "", "2"].indexes(of: elementSet, where: { $0 == $1}).sorted(by: <), [1, 3])
    }
    
    // MARK: - Collection
    
    func testCollection_filterNot() {
        XCTAssertEqual(["1", "2", ""].filterNot(\.isEmpty), ["1", "2"])
    }
    
    // MARK: - Dictionary
    
    func testDictionary_updated() {
        let dict = [1: "1", 2: "two"]
            .updated(value: "2", forKey: 2)
        
        XCTAssertEqual(dict, [1: "1", 2: "2"])
    }
    
    func testDictionary_transformingKeys() throws {
        let dict = [1: 1, 2: 2]
            .transformingKeys(\.description)
        
        XCTAssertEqual(dict, ["1": 1, "2": 2])
        
        //
        
        struct M: Codable {
            var specs: [String: String]
        }
        
        enum E: Int {
            case a, b, c
        }
        
        let json = #"{ "specs" : { "0" : "a", "1" : "b", "2" : "c" } }"#
        
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let model = try JSONDecoder().decode(M.self, from: jsonData)
        let transformedDict = model.specs
            .transformingKeys(Int.init)
            .transformingKeys(E.init(rawValue:))
        
        XCTAssertEqual(transformedDict, [.a: "a", .b: "b", .c: "c"])
    }
    
    // MARK: - String
    
    func testStringExt() {
        // isNilOrEmpty
        XCTAssertTrue(String.isNilOrEmpty(""))
        XCTAssertTrue(String.isNilOrEmpty(nil))
        XCTAssertFalse(String.isNilOrEmpty("A"))
        // ifEmpty
        let a = "A"
        let b = "B"
        XCTAssertEqual("".ifEmpty(a), a)
        XCTAssertEqual(a.ifEmpty(b), a)
    }
    
}
