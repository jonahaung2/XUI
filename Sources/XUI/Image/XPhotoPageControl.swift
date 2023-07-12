//
//  XPhotoPageControl.swift
//  HomeForYou
//
//  Created by Aung Ko Min on 4/7/23.
//

import SwiftUI

public struct XPhotoPageControl: View {
    
    var selection: Binding<Int>
    let length: Int
    let size: CGFloat
    
    public init(selection: Binding<Int>, length: Int, size: CGFloat) {
        self.selection = selection
        self.length = length
        self.size = size
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0...length-1) { i in
                let isSelected = selection.wrappedValue == i
                AsyncButton(actionOptions: []) {
                    selection.wrappedValue = i
                } label: {
                    Circle().fill(.foreground)
                        .frame(square: isSelected ? size/2 : size)
                        .padding(.vertical)
                }
                .buttonStyle(.borderless)
            }
        }
        .animation(.interactiveSpring(), value: selection.wrappedValue)
    }
}
