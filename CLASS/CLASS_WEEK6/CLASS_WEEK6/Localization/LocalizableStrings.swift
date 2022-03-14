//
//  LocalizableString.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import Foundation

enum LocalizableStrings: String {
    case welcome_text
    case data_backup
    
    var localized: String {
        return self.rawValue.localized() //Localizable.strings
    }
    
    var localizedSetting: String {
        return self.rawValue.localized(tableName: "Localizable") //Setting.strings
    }
    
}
