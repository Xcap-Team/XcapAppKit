import XCTest

@testable import XcapAppKit

class CustomTypesTests: XCTestCase {
    
    // MARK: - Angle
    
    func testAngle() {
        let deg = Angle(degrees: 90)
        let rad = Angle(radians: .pi / 2)
        
        XCTAssertEqual(deg, rad)
        XCTAssertEqual(deg.radians, .pi / 2)
        XCTAssertEqual(rad.degrees, 90)
        XCTAssertEqual(deg.degrees, rad.degrees)
        XCTAssertEqual(deg.radians, rad.radians)
    }
    
    // MARK: - Line
    
    func testLine_Hashable() {
        let line1 = Line(start: .zero, end: .init(x: 0, y: 0))
        let line2 = Line(start: .zero, end: .init(x: 1, y: 0))
        let line3 = Line(start: .zero, end: .init(x: 2, y: 0))
        let dict = [
            line1: 0,
            line2: 1,
            line3: 2,
        ]
        
        XCTAssertEqual(dict[line1], 0)
        XCTAssertEqual(dict[line2], 1)
        XCTAssertEqual(dict[line3], 2)
    }
    
    func testLine_vars() {
        let line1 = Line(start: .zero, end: CGPoint(x: 10, y: 10))
        
        XCTAssertEqual(line1.dx, 10)
        XCTAssertEqual(line1.dy, 10)
        XCTAssertEqual(line1.mid, .init(x: 5, y: 5))
        XCTAssertEqual(Angle(radians: line1.angle), Angle(degrees: 45))
    }
    
    func testLine_contains() {
        let line = Line(start: .zero, end: CGPoint(x: 10, y: 10))
        
        XCTAssertTrue(line.contains(.init(x: 5, y: 5)))
    }
    
    func testLine_rotated() {
        var line = Line(start: .zero, end: CGPoint(x: 10, y: 0))
        
        line.rotate(angle: Angle(degrees: 90))
        
        XCTAssertEqual(line.start, .zero)
        XCTAssertLessThan(line.end.x, 1e-5)
        XCTAssertEqual(line.end.y, 10)
    }
    
    func testLine_intersectionType() {
        let line = Line(start: .zero, end: CGPoint(x: 10, y: 10))
        let line2 = Line(start: .init(x: 0, y: 1), end: CGPoint(x: 10, y: 11))
        let line3 = Line(start: .init(x: 10, y: 0), end: CGPoint(x: 0, y: 10))
        
        XCTAssertEqual(line.intersection(with: line2), .parallel)
        XCTAssertEqual(line.intersection(with: line3), .cross(.init(x: 5, y: 5)))
    }
    
    func testLine_collides() {
        let line = Line(start: .zero, end: CGPoint(x: 10, y: 10))
        let line2 = Line(start: .init(x: 0, y: 1), end: CGPoint(x: 10, y: 11))
        let line3 = Line(start: .init(x: 10, y: 0), end: CGPoint(x: 0, y: 10))
        
        XCTAssertFalse(line.collides(with: line2))
        XCTAssertTrue(line.collides(with: line3))
    }
    
    // MARK: - Circle
    
    func testCircle_Hashable() {
        let circle1 = Circle(center: .zero, radius: 0)
        let circle2 = Circle(center: .zero, radius: 1)
        let circle3 = Circle(center: .zero, radius: 2)
        let dict = [
            circle1: 0,
            circle2: 1,
            circle3: 2,
        ]
        
        XCTAssertEqual(dict[circle1], 0)
        XCTAssertEqual(dict[circle2], 1)
        XCTAssertEqual(dict[circle3], 2)
    }
    
    func testCircle_initWith3Points() {
        XCTAssertNil(Circle(.zero, .zero, .zero))
        XCTAssertNil(Circle(.init(x: -10, y: 0), .init(x: 0, y: 0), .init(x: 10, y: 0)))
        XCTAssertNil(Circle(.init(x: 0, y: 10), .init(x: 0, y: 0), .init(x: 0, y: -10)))
        
        let p1 = CGPoint(x: -10, y: 0)
        let p2 = CGPoint(x: 10, y: 0)
        let p3 = CGPoint(x: 0, y: 10)
        
        guard let circle = Circle(p1, p2, p3) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(circle.radius, 10)
        XCTAssertEqual(circle.center, .zero)
        
        XCTAssertTrue(circle.contains(.zero))
        XCTAssertTrue(circle.contains(p1))
        XCTAssertTrue(circle.contains(p2))
        XCTAssertTrue(circle.contains(p3))
        XCTAssertFalse(circle.contains(.init(x: 11, y: 0)))
    }
    
    // MAKR: - Arc
    
    func testArc_init() {
        let arc1 = Arc(vertex: .zero,
                       radius: 10,
                       point1: .init(x: 10, y: -10),
                       point2: .init(x: 10, y: 10))
        
        XCTAssertEqual(arc1.angle, Angle(degrees: 90).radians)
        XCTAssertTrue(arc1.clockwise)
        
        let arc2 = Arc(vertex: .zero,
                       radius: 10,
                       point1: .init(x: 10, y: 0),
                       point2: .init(x: -10, y: -10))
        
        XCTAssertEqual(arc2.angle, Angle(degrees: 135).radians)
        XCTAssertFalse(arc2.clockwise)
    }
    
    func testArc_Hashable() {
        let arc1 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 0).radians,
                       end: Angle(degrees: 0).radians,
                       clockwise: true)
        let arc2 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 0).radians,
                       end: Angle(degrees: 1).radians,
                       clockwise: true)
        let arc3 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 0).radians,
                       end: Angle(degrees: 2).radians,
                       clockwise: true)
        let dict = [
            arc1: 0,
            arc2: 1,
            arc3: 2,
        ]
        
        XCTAssertEqual(dict[arc1], 0)
        XCTAssertEqual(dict[arc2], 1)
        XCTAssertEqual(dict[arc3], 2)
    }
    
    func testArc_angle() {
        // 45 ~ 225
        
        var arc1 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 45).radians,
                       end: -Angle(degrees: 135).radians,
                       clockwise: true)
        
        XCTAssertEqual(arc1.angle, Angle(degrees: 180).radians)
        arc1.clockwise.toggle()
        XCTAssertEqual(arc1.angle, Angle(degrees: 180).radians)
        
        // 90 ~ 360
        
        var arc2 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 90).radians,
                       end: Angle(degrees: 0).radians,
                       clockwise: true)
        
        XCTAssertEqual(arc2.angle, Angle(degrees: 270).radians)
        arc2.clockwise.toggle()
        XCTAssertEqual(arc2.angle, Angle(degrees: 90).radians)
        
        // 45 ~ 270
        
        var arc3 = Arc(center: .zero,
                       radius: 10,
                       start: -Angle(degrees: 90).radians,
                       end: Angle(degrees: 45).radians,
                       clockwise: true)
        
        XCTAssertEqual(arc3.angle, Angle(degrees: 135).radians)
        arc3.clockwise.toggle()
        XCTAssertEqual(arc3.angle, Angle(degrees: 225).radians)
    }
    
    func testArc_contains_angle() {
        // 45 ~ 315
        
        let arc1 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 45).radians,
                       end: -Angle(degrees: 45).radians,
                       clockwise: true)
        
        for deg in 45...315 {
            let angle = Angle(degrees: CGFloat(deg))
            XCTAssertTrue(arc1.contains(angle.radians), "deg=\(deg)")
        }
        
        for deg in -44...44 {
            let angle = Angle(degrees: CGFloat(deg))
            XCTAssertFalse(arc1.contains(angle.radians), "deg=\(deg)")
        }
        
        // -45 ~ 45
        
        let arc2 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 45).radians,
                       end: -Angle(degrees: 45).radians,
                       clockwise: false)
        
        for deg in -45...45 {
            let angle = Angle(degrees: CGFloat(deg))
            XCTAssertTrue(arc2.contains(angle.radians), "deg=\(deg)")
        }
        
        for deg in 46...314 {
            let angle = Angle(degrees: CGFloat(deg))
            XCTAssertFalse(arc2.contains(angle.radians), "deg=\(deg)")
        }
    }
    
    func testArc_contains_point() {
        let eps = 1e-5
        
        // 45 ~ 90
        
        let arc1 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 45).radians,
                       end: Angle(degrees: 90).radians,
                       clockwise: true)
        
        for deg in 45...90 {
            let angle = Angle(degrees: CGFloat(deg))
            let point = arc1.center.extended(length: arc1.radius - eps, angle: angle.radians)
            XCTAssertTrue(arc1.contains(point), "deg=\(deg)")
        }
        
        for deg in -269...44 {
            let angle = Angle(degrees: CGFloat(deg))
            let point = arc1.center.extended(length: arc1.radius - eps, angle: angle.radians)
            XCTAssertFalse(arc1.contains(point), "deg=\(deg)")
        }
        
        // -270 ~ 45
        
        let arc2 = Arc(center: .zero,
                       radius: 10,
                       start: Angle(degrees: 45).radians,
                       end: Angle(degrees: 90).radians,
                       clockwise: false)
        
        for deg in -270...45 {
            let angle = Angle(degrees: CGFloat(deg))
            let point = arc2.center.extended(length: arc2.radius - eps, angle: angle.radians)
            XCTAssertTrue(arc2.contains(point), "deg=\(deg)")
        }
        
        for deg in 46...89 {
            let angle = Angle(degrees: CGFloat(deg))
            let point = arc2.center.extended(length: arc2.radius - eps, angle: angle.radians)
            XCTAssertFalse(arc2.contains(point), "deg=\(deg)")
        }
    }
    
}
