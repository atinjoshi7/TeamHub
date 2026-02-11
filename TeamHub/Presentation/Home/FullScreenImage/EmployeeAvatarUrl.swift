//
//  EmployeeAvatarUrl.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI
import Kingfisher

import Foundation

enum EmployeeAvatarUrl {

    static func make(from urlString: String?) -> URL? {

        guard let urlString = urlString?
            .trimmingCharacters(in: .whitespacesAndNewlines) else {
            return nil
        }

        if urlString.isEmpty {
            return nil
        }

        return URL(string: urlString)
    }
}

