//
//  String+Extension.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import Foundation

extension String {
    var localized: Self {
        NSLocalizedString(self, comment: "")
    }
}
