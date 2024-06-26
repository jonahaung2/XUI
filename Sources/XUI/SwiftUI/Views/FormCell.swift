//
//  FormCell.swift
//  RoomRentalDemo
//
//  Created by Aung Ko Min on 19/1/23.
//

import SwiftUI

public struct _FormCell<Left: View, Right: View>: View {
    
    @ViewBuilder private var left: () -> Left
    @ViewBuilder private var right: () -> Right

    public init(left: @escaping () -> Left, right: @escaping () -> Right) {
        self.left = left
        self.right = right
    }

    public var body: some View {
        HStack {
            left()
            Spacer()
            right()
        }
    }
}
