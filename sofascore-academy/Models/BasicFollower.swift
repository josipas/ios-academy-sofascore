import Foundation

struct BasicFollower: Decodable {
    var login: String
    var avatarUrl: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case url
    }
}
