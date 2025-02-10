import Foundation

public struct NetworkService: Sendable {

     let apiBuilder: APIBuilder
     let decoder: JSONDecoder
     let session: URLSession

public init(
        apiBuilder: APIBuilder = APIBuilder(),
        decoder: JSONDecoder = JSONDecoder(),
        session: URLSession = .shared
    ) {
        self.apiBuilder = apiBuilder
        self.decoder = decoder
        self.session = session
    }

    public func fetchNumberFact(
        for number: String, completion: @Sendable @escaping (String?) -> Void
    ) {
        let urlString = apiBuilder.numberFactURL(for: number)
        fetch(
            urlString: urlString, expecting: String.self, completion: completion
        )
    }

    public func fetchRandomFactInRange(
        min: Int, max: Int, completion: @Sendable @escaping (String?) -> Void
    ) {
        let urlString = apiBuilder.randomFactInRangeURL(min: min, max: max)
        fetch(
            urlString: urlString, expecting: String.self, completion: completion
        )
    }

    public func fetchMultipleNumbersFacts(
        numbersQuery: String, completion: @Sendable @escaping ([String: String]?) -> Void
    ) {
        let urlString = apiBuilder.multipleNumbersFactsURL(
            numbersQuery: numbersQuery)
        fetch(
            urlString: urlString, expecting: [String: String].self,
            completion: completion)
    }

    private func fetch<T: Decodable>(
        urlString: String, expecting: T.Type, completion: @escaping @Sendable (T?) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        session.dataTask(with: url) { [completion] data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if T.self == String.self {
                let stringResponse = String(data: data, encoding: .utf8) as? T
                completion(stringResponse)
            } else {
                do {
                    let decodedResponse = try self.decoder.decode(T.self, from: data)
                    completion(decodedResponse)
                } catch {
                    completion(nil)
                }
            }
        }.resume()
    }
}
