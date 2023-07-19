//
//  File.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/19/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

/// Extension that makes it easier to deal with HTML endcoded text.
extension String {
    var html2String: String? {
        
        ///options keys to convert html encoded text to normal text
        let convertHtmlOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue]
        
        //using this String's self data--almost like magic
        guard let data = data(using: .utf8) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data,
                                          options: convertHtmlOptions,
                                          documentAttributes: nil).string
        } catch {
            print("Error converting from HTML encoded text. Error: \(error)")
            return nil
            
        }
    }
}
