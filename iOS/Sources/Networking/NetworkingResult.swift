import Foundation

enum NetworkingResult: Int {
    case okay = 200
    case created = 201
    case badRequest = 400
    case notFound = 404
    case fault = 0
}
