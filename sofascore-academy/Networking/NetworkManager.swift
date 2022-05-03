import Foundation

public class NetworkManager {

    static let shared = NetworkManager()

    private init () {} // create only one instance!

    func getFollowers(for username: String, completed: @escaping (Result<Follower, CustomError>) -> Void ) {

            let endpoint = "https://api.github.com" + "/users/" + "\(username)"

            guard let url = URL(string: endpoint) else {
                completed(.failure(.error))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let _ = error {
                    completed(.failure(.unableToComplete))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
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

}

