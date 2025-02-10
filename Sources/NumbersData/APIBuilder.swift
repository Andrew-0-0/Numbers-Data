import Foundation

public struct APIBuilder: Sendable {
    private let baseURL = "http://numbersapi.com"

    public init() {}

    public func numberFactURL(for number: String) -> String {
        return "\(baseURL)/\(number)"
    }

    public func randomFactInRangeURL(min: Int, max: Int) -> String {
        return "\(baseURL)/random?min=\(min)&max=\(max)"
    }

    public func multipleNumbersFactsURL(numbersQuery: String) -> String {
        return "\(baseURL)/\(numbersQuery)?json"
    }
}
