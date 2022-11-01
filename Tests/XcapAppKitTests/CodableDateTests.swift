import XCTest
@testable import XcapAppKit

struct TestDateConverter: FormatableDateConverter {
    static var dateFormat: String { "yyyy-MM-dd" }
}

struct TestModel: Codable, Equatable {
    @CodableDate<TestDateConverter>
    var date: Date
}

final class CodableDateTests: XCTestCase {
    
    func testCodableDate() throws {
        let dateString = "1993-03-01"
        let json = #"{"date" : "\#(dateString)"}"#
        
        guard let data = json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let model = try JSONDecoder().decode(TestModel.self, from: data)
        let encodedData = try JSONEncoder().encode(model)
        let decodedModel = try JSONDecoder().decode(TestModel.self, from: encodedData)
        
        XCTAssertEqual(model.$date, dateString)
        XCTAssertEqual(model, decodedModel)
    }
    
}
