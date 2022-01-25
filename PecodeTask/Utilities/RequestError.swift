//
//  RequestError.swift
//  PecodeTask
//
//  Created by Эдип on 24.01.2022.
//

import Foundation

enum RequestError: String, Error {
    case invalidRequestParameters       = "This pThis parameters created an invalid request created an invalid request. Please try again."
    case unableToComplete               = "Unable to comlete your request. Please chek your internet connection"
    case invalidResponse                = "Invalid response from the server. Please try again."
    case invalidData                    = "The data received from the server was invalid. Pleas try again"
}
