//
//  autoApp.swift
//  auto
//
//  Created by Igor Korovyanskiy on 21.02.2022.
//

import SwiftUI

@main
struct autoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

let weightKg = 2108
let lengthMm = 4976
let widthMm = 1963
let heightMm = 1435
let wheelBaseMM = 2959
let clyrenceMM = 154.9
let trunkVolumeL = 900



enum AutoError: Error {
    case isLost // заблудился
    case lowBattery // низкая батарея
    case brokeAutoDrive // проблемы с управлением машины
}
 

var isLost: Bool = false
var lowBattery: Bool = false
var brokeAutoDrive: Bool = true
 
func autoDrive() throws {
    if isLost {
        throw AutoError.isLost
    }
 
    if lowBattery {
        throw AutoError.lowBattery
    }
 
    if brokeAutoDrive {
        throw AutoError.brokeAutoDrive
    }
}
 
do {
    try autoDrive()
} catch AutoError.isLost {
    print("Вы заблудились! Включаю GPS")
} catch AutoError.lowBattery {
    print("Батарея садится! Ближайшая станция подзарядки через 1 км 300 м")
} catch AutoError.brokeAutoDrive {
    print("Режим автопилота поврежден. Переходим в режим ручного управления!")
}
