//
//  NavigationState.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//
import SwiftUI

enum ViewPathType: Hashable {
    case login
    case homeView
    case activity
    case chatBot
    case timerView(activity: ActivityDto)
    case resultView
}



struct ViewPath: Hashable {
    let type: ViewPathType
   // let timerValue: Float?
}
