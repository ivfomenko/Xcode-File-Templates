//
//  StoryboardInitializable.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

enum AppStoryboards: String, CaseIterable {
    
    var storyboard: String {
        return self.rawValue + "View"
    }
}
