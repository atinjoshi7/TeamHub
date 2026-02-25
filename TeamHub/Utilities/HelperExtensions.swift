//
//  HelperExtensions.swift
//  TeamHub
//
//  Created by Jarvis on 19/02/26.
//

import Foundation
import UIKit

 extension JSONDecoder {
    static var employeesDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.joiningDateFormatter)
        return decoder
    }
}

extension DateFormatter {
    static let joiningDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
}
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
