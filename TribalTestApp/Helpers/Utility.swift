//
//  Utility.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import Foundation
import UIKit

class Utility: NSObject {
    static func calculateImageHeight (sourceImage : Photo, scaledToWidth: CGFloat) -> CGFloat {
        let oldWidth = CGFloat( sourceImage.width)
        let scaleFactor = scaledToWidth / oldWidth
        let newHeight = CGFloat(sourceImage.height) * scaleFactor
        return newHeight
    }
    
    static func formatDateAndHourBy(dateStr : String) -> String {
        //2020-10-26T23:09:39.000Z
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-HH:mm"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yy, h:mm a" //Specify your format that you want

        if let date = dateFormatterGet.date(from: dateStr) {
            return dateFormatterPrint.string(from: date)
        } else {
            return dateStr
        }
    }
}
