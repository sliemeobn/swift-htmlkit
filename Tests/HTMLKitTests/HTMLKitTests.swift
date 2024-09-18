//
//  HTMLKitTests.swift
//
//
//  Created by Evan Anderson on 9/16/24.
//

import XCTest
@testable import HTMLKit

final class HTMLKitTests : XCTestCase {
    func testExample() throws {
    }
}

extension HTMLKitTests {
    func test_element_html() {
        XCTAssertEqual(#html([]), "<!DOCTYPE html><html></html>")
        XCTAssertEqual(#html(xmlns: "test", []), "<!DOCTYPE html><html xmlns=\"test\"></html>")
    }
    func test_element_canvas() {
        XCTAssertEqual(#canvas(height: .percent(4), width: .em(2.69)), "<canvas height=\"4.0%\" width=\"2.69em\"></canvas>")
    }
    func test_element_input() {
        let string:String = #input(type: .text)
        XCTAssertEqual(string, "<input type=\"text\">")
    }
}

extension HTMLKitTests {
    func test_recursive() {
        let string:String = #div([
            #div(),
            #div([#div(), #div(), #div()]),
            #div()
        ])
        XCTAssertEqual(string, "<div><div></div><div><div></div><div></div><div></div></div><div></div></div>")
    }
    func test_void() {
        let string:String = #area([#base(), #br(), #col(), #embed(), #hr(), #img(), #input(), #link(), #meta(), #source(), #track(), #wbr()])
        XCTAssertEqual(string, "<area><base><br><col><embed><hr><img><input><link><meta><source><track><wbr>")
    }
}

extension HTMLKitTests {
    func test_attribute_data() {
        let bro:Int = 0
        let string:String = #div(attributes: [.data(id: "id", "\(bro)")])
        XCTAssertEqual(string, "<div data-id=\"\(bro)\"></div>")
    }
}

extension HTMLKitTests {
    func test_example_1() {
        let test:String = #html([
            #body([
                #div(
                    attributes: [
                        .class(["bing", "bong"]),
                        .title("just seeing what blow's"),
                        .draggable(.false),
                        .inputMode(.email),
                        .hidden(.hidden)
                    ],
                    [
                        "poggies",
                        #div(),
                        #a([#div([#abbr()]), #address()]),
                        #div(),
                        #button(disabled: true),
                        #video(autoplay: true, controls: false, height: nil, preload: .auto, src: "ezclap", width: .centimeters(1)),
                    ]
                )
            ])
        ])
        XCTAssertEqual(test, "<!DOCTYPE html><html><body><div class=\"bing bong\" title=\"just seeing what blow's\" draggable=\"false\" inputmode=\"email\" hidden=\"hidden\">poggies<div></div><a><div><abbr></abbr></div><address></address></a><div></div><button disabled></button><video autoplay preload=\"auto\" src=\"ezclap\" width=\"1.0cm\"></video></div></body></html>")
    }
}

extension HTMLKitTests {
    func testExample2() {
        var test:TestStruct = TestStruct(name: "one", array: ["1", "2", "3"])
        XCTAssertEqual(test.html, "<p>one123</p>")
        
        test.name = "two"
        test.array = [4, 5, 6, 7, 8]
        XCTAssertEqual(test.html, "<p>two45678</p>")
    }
    struct TestStruct {
        var name:String
        var array:[CustomStringConvertible]
        
        var html : String { #p(["\(name)", "\(array.map({ "\($0)" }).joined())"]) }
    }
}
