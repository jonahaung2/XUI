//
//  AlertViewModifier.swift
//  XUI
//
//  Created by Aung Ko Min on 27/1/23.
//

import SwiftUI

public struct AlertViewModifier: ViewModifier {
    
    @StateObject private var alertManager = AlertManager()
    
    public func body(content: Content) -> some View {
        content
            .alert(item: $alertManager.alertItem, content: { (item) -> Alert in
                if item.dismiss != nil {
                    if let type = item.dismiss {
                        return Alert(title: Text(type.title), message: Text(type.message), dismissButton: type.dismissButton)
                    } else {
                        return Alert(title: Text("Error"), message: Text("Something went terribly wrong"), dismissButton: .cancel(Text("OK")))
                    }
                } else if item.primarySecondary != nil {
                    if let type = item.primarySecondary {
                        return Alert(title: Text(type.title), message: Text(type.message), primaryButton: type.primaryButton ?? .default(Text("OK")), secondaryButton: type.secondaryButton ?? .cancel())
                    } else {
                        return Alert(title: Text("Error"), message: Text("Something went terribly wrong"), dismissButton: .cancel(Text("OK")))
                    }
                } else {
                    return Alert(title: Text("Error"), message: Text("Something went terribly wrong"), dismissButton: .cancel(Text("OK")))
                }
            })
            .actionSheet(item: $alertManager.actionSheetItem) { (item) -> ActionSheet in
                let type = item.defaultActionSheet
                return ActionSheet(title: Text(type.title), message: Text(type.message), buttons: type.buttons)
            }
            .environmentObject(alertManager)
    }
}

extension View {
    public func injectAlertManager() -> some View {
        self.modifier(AlertViewModifier())
    }
    public func customAlert<AlertContent: View>(manager: CustomAlertManager, content: @escaping () -> AlertContent, buttons: [CustomAlertButton]) -> some View {
        self.modifier(CustomAlertViewModifier(customAlertManager: manager, alertContent: content, buttons: buttons))
    }
}
