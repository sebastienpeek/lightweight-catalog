import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(apple_network_packageTests.allTests),
    ]
}
#endif
