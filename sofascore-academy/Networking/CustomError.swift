import Foundation

enum CustomError: String, Error {
    case invalidResponse  = "Invalid response from the server, please try again."
    case unableToComplete = "Unable to complete request, please check your internet connection."
    case invalidData = "The data recieved from the server is invalid, please try again."
    case invalidUrl = "URL couldn't be created"
    case decodeError = "Decode went wrong"
    case error = "Error"
}
