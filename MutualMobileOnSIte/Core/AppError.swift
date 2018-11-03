//
//  AppError.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//}

import Foundation

class AppError: Error {
    private var errorType: ErrorType
    private var originalMessage: String?
    var errorCode: String?

    internal enum ErrorType {
        case networkError
        case fetchError
    }

    var message: String? {
        var errorString: String
        switch errorType {
        case .networkError:
            errorString = "Currently, Network is not available"
        case .fetchError:
            errorString = "Unable to fetch the data"
        }
        return errorString
    }

    required init(with errorType: ErrorType, message: String? = nil) {
        self.errorType = errorType
        self.originalMessage = message
    }
}
