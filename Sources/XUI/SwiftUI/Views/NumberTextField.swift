//
//  IntTextField.swift
//  HomeForYou
//
//  Created by Aung Ko Min on 30/1/23.
//

import SwiftUI

public struct _NumberTextField: View {
    
    private var value: Binding<Int>
    private let title: String
    private let delima: String?
    
    public init(value: Binding<Int>, title: String, delima: String? = nil) {
        self.value = value
        self.title = title
        self.delima = delima
    }
    
    public var body: some View {
        HStack {
            Text(.init(title))
                .foregroundStyle(value.wrappedValue > 0 ? .secondary : .primary)
            
            TextField("\(delima.str)", text: .init(get: getValue, set: setValue(_:)))
                .keyboardType(.numberPad)
                .bold()
                .multilineTextAlignment(.trailing)
        }
    }
    
    private func getValue() -> String {
        if value.wrappedValue == 0 { return String() }
        return "\(delima.str)\(value.wrappedValue)"
    }
    
    private func setValue(_ newValue: String) {
        value.wrappedValue = Int(newValue.replace(delima.str, with: "")) ?? 0
    }
}
