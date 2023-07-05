import Foundation

struct CommunityDataModel: Codable {
    let postList: [Post]
}

struct Post: Codable {
    let id: Int
    let category: String
    let title: String
    let content: String
    let region: String
    let view: Int
}
