//
//  SideMenuOptionModel.swift
//  GameOnSwiftUI
//
//  Created by Anaia Hoard on 12/06/2024.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable{
    case map
    case profile
    case settings
    case notifications
    
    var title: String{
        switch self{
        case.map: return "Map"
        case.profile: return "Profile & Settings"
        case.settings: return "Settings"
        case.notifications: return "Notifications"
        }
    }
    var systemImageName: String{
        switch self{
        case.map: return "filemenu.and.cursorarrow"
        case.profile: return "person"
        case.settings: return "gear"
        case.notifications: return "bell"
        }
    }
}

extension SideMenuOptionModel: Identifiable{
    var id: Int {return self.rawValue}
}
