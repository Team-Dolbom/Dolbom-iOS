import Foundation

struct OfferDataModel: Codable {
    let offerList: [Offer]
}

struct Offer: Codable {
    let id: Int
    let babySitter: Bool
    let title: String
    let content: String
    let region: String
    let view: Int
}
