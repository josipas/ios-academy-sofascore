import Foundation

struct Follower: Codable {
    var url: String
    var followers_url: String
    var followers: Int
    var following: Int
    var public_repos: Int
    var public_gists: Int
    var bio: String
    var company: String
    var name: String?
    var location: String?
    var login: String
}
