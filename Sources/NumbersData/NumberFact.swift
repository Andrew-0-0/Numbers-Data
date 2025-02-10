import UIKit

public struct NumberFact {
    public let number: String
    public let description: String
}
    extension NumberFact {
        public init?(fact: String) {
        guard let range = fact.range(of: ":") else {
            return nil
        }
        self.number = String(fact[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
        self.description = String(fact[range.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
    }

        public init() {
        self.number = "No Number"
        self.description = "No fact available."
    }
}
