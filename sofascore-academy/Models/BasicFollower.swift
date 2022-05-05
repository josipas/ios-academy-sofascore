import Foundation

struct BasicFollower: Decodable, Hashable {
    var login: String
    var avatarUrl: String
    var url: String
    var followersUrl: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case url
        case followersUrl = "followers_url"
    }
}
