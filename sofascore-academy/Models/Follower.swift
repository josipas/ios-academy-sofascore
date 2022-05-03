import Foundation

struct Follower: Decodable {
    var profileUrl: String
    var followersUrl: String
    var followers: Int
    var following: Int
    var publicRepos: Int
    var publicGists: Int
    var bio: String
    var company: String?
    var name: String?
    var location: String?
    var login: String
    var avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case profileUrl = "html_url"
        case followersUrl = "followers_url"
        case followers
        case following
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case bio
        case company
        case name
        case location
        case login
        case avatarUrl = "avatar_url"
    }
}
