//
//  SettingsSection.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit
protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social 
    case Communications
    
    var description: String {
        switch self {
        case .Social: return "Settings"
        case .Communications: return "Communications"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType {
    case contact
    case officer
    case logout
    case about
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .contact: return "Contact"
        case .officer: return "Officers"
        case .logout: return "Log Out"
        case .about: return "About Us"
        }
    }
}


enum CommunicationOptions: Int, CaseIterable, SectionType {
    case email
    case reportCrashes
    case notifications
    
    var containsSwitch: Bool {
        switch self {
        case .email: return true
        case .reportCrashes: return true
        case .notifications: return true
        }
    }
    
    var description: String {
        switch self {
        case .notifications: return "Notifications"
        case .email: return "Email"
        case .reportCrashes: return "Report Crashes"
        }
    }
}
