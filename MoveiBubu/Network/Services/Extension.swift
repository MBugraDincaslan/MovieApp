//
//  Extension.swift
//  MoveiBubu
//
//  Created by obss on 11.07.2022.
//

import UIKit
import Kingfisher

struct constant {
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
}

extension UIImageView {
    func getImage(path: String?) {
        if let path = path {
            if let url = URL(string: constant.baseImageURL + path){
                self.kf.setImage(with: url)
            } else {
                self.image = UIImage(named: "noImage")
            }
        } else {
            self.image = UIImage(named: "noImage")
        }
        
    }
}
extension Int {
    var formattedWithSeparator: String {

            return Formatter.withSeparator.string(for: self) ?? ""

        }

}
extension Formatter {

    static let withSeparator: NumberFormatter = {

        let formatter = NumberFormatter()

        formatter.groupingSeparator = "."

        formatter.numberStyle = .decimal

        return formatter

    }()

}
