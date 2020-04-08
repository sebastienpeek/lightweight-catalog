import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(apple_data_packageTests.allTests),
    ]
}
#endif
