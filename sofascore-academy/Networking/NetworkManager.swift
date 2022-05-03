import Foundation

public class NetworkManager {

    static let shared = NetworkManager()

    private init () {} // create only one instance!

    func getWoeid(for city: String, completed: @escaping (Result<[City], CustomError>) -> Void) {
        var endpoint = URLComponents()

        endpoint.scheme = "https"
        endpoint.host = "www.metaweather.com"
        endpoint.path = "/api/location/search/"

        endpoint.queryItems = [URLQueryItem(name: "query", value: city.lowercased())]

        guard let url = URL(string: endpoint.string!) else {
            completed(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.error))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let city = try decoder.decode([City].self, from: data)
                completed(.success(city))
            } catch {
                completed(.failure(.decodeError))
            }
        }
        task.resume()
    }

}

