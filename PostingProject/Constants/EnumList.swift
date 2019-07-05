//
//  EnumList.swift
//  AssetIntelligence
//
//  Created by LUCAS on 3/18/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import Foundation
import SwiftDate

enum EnumStationSelectionType: String {
    case `operator`, neuron, meter
}

enum EnumDateFormat: String {
    case fullDate = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    case fullDayInWeek = "eee, dd-MMM-yyyy"
    case dayInWeek = "eee, MMM dd"
    case dayInWeek2 = "cccc, MMM dd"
    case dayInWeek3 = "eee dd"
    case dayInWeekShort = "MMM dd hh:mm a"
    case hourInDay = "hh:mm a"
    case dayInWeekAndHourInDay = "eee, MMM dd hh:mm a"
    case dayInWeekHasYear = "eee, MMM dd yyyy"
    
    case defaultFormat = "yyyy-MM-dd HH:mm:ss"
    case bookedDateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    case calendar = "MMMM, yyyy"
    case defaultCalendar = "dd MMMM, yyyy"
    case facilityDateFormat = "MMM dd, yyyy hh:mm a"
    case birthdayFormat = "MMM dd, yyyy"
    case matchupDateFormat = "dd/MM"
    case dateTimeInRangeFull = "hh:mm a, dd MMM yyyy"
    case dateTimeInRangeNoYear = "hh:mm a, dd MMM"
    case dateTimeInRangeNoMonth = "hh:mm a, dd"
    case dateTimeInRangeDateMonth = "MMM dd"
    case getHour = "HH"
    case getMinute = "mm"
    case dateActivity = "hh:mm a - MMM dd, yyyy"
    case onlyDayInWeek = "eee"
}

enum EnumMapObjectType {
    case asset, truck, carriage, storage
}
