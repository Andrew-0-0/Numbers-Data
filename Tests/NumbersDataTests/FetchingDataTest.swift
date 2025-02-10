import XCTest

@testable import NumbersData

final class FetchingDataTest: XCTestCase {
    var networkService: NetworkService!
    var mockSession: URLSession!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: configuration)
        networkService = NetworkService(session: mockSession)
    }

    override func tearDownWithError() throws {
        networkService = nil
        mockSession = nil
        MockURLProtocol.testData = nil
        MockURLProtocol.responseError = nil
    }

    func testFetchNumberFact() {
        // Arrange
        let testNumber = "42"
        MockURLProtocol.testData = """
        42 is the answer to life, the universe, and everything.
        """.data(using: .utf8)
        
        let expectation = XCTestExpectation(description: "Fetch number fact")

        // Act
        networkService.fetchNumberFact(for: testNumber) { fact in
            // Assert
            XCTAssertNotNil(fact)
            XCTAssertEqual(fact, "42 is the answer to life, the universe, and everything.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchRandomNumberFact() {
            // Arrange
            MockURLProtocol.testData = """
            17 is a prime number.
            """.data(using: .utf8)

            let expectation = XCTestExpectation(description: "Fetch random number fact")

            // Act
            networkService.fetchNumberFact(for: "random") { fact in
                // Assert
                XCTAssertNotNil(fact)
                XCTAssertEqual(fact, "17 is a prime number.")
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 1.0)
        }

    func testFetchRandomFactInRange() {
        // Arrange
        MockURLProtocol.testData = """
        15 is a triangular number.
        """.data(using: .utf8)
        
        let expectation = XCTestExpectation(description: "Fetch random fact in range")

        // Act
        networkService.fetchRandomFactInRange(min: 10, max: 20) { fact in
            // Assert
            XCTAssertNotNil(fact)
            XCTAssertEqual(fact, "15 is a triangular number.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchMultipleNumbersFacts() {
        // Arrange
        MockURLProtocol.testData = """
        {
            "1": "1 is the first positive number.",
            "2": "2 is the only even prime number.",
            "3": "3 is the first odd prime number."
        }
        """.data(using: .utf8)

        let expectation = XCTestExpectation(description: "Fetch multiple numbers facts")

        // Act
        networkService.fetchMultipleNumbersFacts(numbersQuery: "1,2,3") { facts in
            // Assert
            XCTAssertNotNil(facts)
            XCTAssertEqual(facts?["1"], "1 is the first positive number.")
            XCTAssertEqual(facts?["2"], "2 is the only even prime number.")
            XCTAssertEqual(facts?["3"], "3 is the first odd prime number.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

