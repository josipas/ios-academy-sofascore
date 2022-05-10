import Foundation

public class NetworkManager {

    static let shared = NetworkManager()

    private init () {} // create only one instance!

    func getFollowerDetails(for username: String, completed: @escaping (Result<Follower, CustomError>) -> Void ) {

        let endpoint = "https://api.github.com" + "/users/" + "\(username)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.unableToComplete))
                return
            }

            do {
                let decoder = JSONDecoder()
                let follower = try decoder.decode(Follower.self, from: data)
                completed(.success(follower))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getFollowers(for followersUrl: String, completed: @escaping (Result<[BasicFollower], CustomError>) -> Void ) {

        let endpoint = followersUrl

        guard let url = URL(string: endpoint) else {
            completed(.failure(.error))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.unableToComplete))
                return
            }

            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([BasicFollower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getWoeid(for city: String, completed: @escaping (Result<[City], CustomError>) -> Void) {
        var endpoint = URLComponents()

        endpoint.scheme = "https"
        endpoint.host = "www.metaweather.com"
        endpoint.path = "/api/location/search/"

        endpoint.queryItems = [URLQueryItem(name: "query", value: city.lowercased())]

        guard
            let endpointStr = endpoint.string,
            let url = URL(string: endpointStr)
        else {
            completed(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.error))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
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

