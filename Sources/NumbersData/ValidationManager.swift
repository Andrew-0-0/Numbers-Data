import Foundation

public struct ValidationManager {
    public init() {}

    public func validateUserNumberInput(_ input: String?) -> Bool {
        guard let input = input, !input.isEmpty,
            !input.contains(where: { !$0.isNumber })
        else {
            return false
        }
        return true
    }

    public func validateRangeInput(_ rangeText: String?) -> (min: Int, max: Int)? {
        guard let rangeText = rangeText else { return nil }
        let components = rangeText.split(separator: "-").compactMap { Int($0) }
        guard components.count == 2, let min = components.first,
            let max = components.last, min < max
        else {
            return nil
        }
        return (min, max)
    }

    public func validateMultipleNumbersInput(_ input: String?) -> Bool {
        guard let input = input else { return false }
        let validInputRegex = "^(\\d+|\\d+\\.\\.\\d+)(,\\d+|,\\d+\\.\\.\\d+)*$"
        return matchesRegex(input, regex: validInputRegex)
    }

    public func containsOnlyAllowedCharacters(_ string: String) -> Bool {

        if string.isEmpty {
            return true
        }

        var allowedCharacterSet = CharacterSet.decimalDigits
        allowedCharacterSet.insert(charactersIn: "-.,")

        let rangeOfNonAllowedCharacters = string.rangeOfCharacter(
            from: allowedCharacterSet.inverted)

        return rangeOfNonAllowedCharacters == nil
    }

    private func matchesRegex(_ input: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }
}
