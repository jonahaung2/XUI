//
//  Haptics.swift
//  HomeForYou
//
//  Created by Aung Ko Min on 8/2/23.
//

import SwiftUI
import AudioToolbox
import CoreHaptics

public struct _Haptics {
    public static func play(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        guard !isLegacyTapticEngine else {
            generateLegacyFeedback()
            return
        }
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    public static func generateNotificationFeedback(style: UINotificationFeedbackGenerator.FeedbackType) {
        guard !isLegacyTapticEngine else {
            generateLegacyFeedback()
            return
        }
        UINotificationFeedbackGenerator().notificationOccurred(style)
    }
    
    private static func generateLegacyFeedback() {
        AudioServicesPlaySystemSound(1519)
        AudioServicesPlaySystemSound(1520)
        AudioServicesPlaySystemSound(1521)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    private static let isLegacyTapticEngine: Bool = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return ["iPhone8,1", "iPhone8,2"].contains(identifier)
    }()
}
