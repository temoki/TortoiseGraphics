//
//  ColorPalette.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class ColorPalette {

    // Material Design: Color Palette
    // https://material.google.com/style/color.html
    private static var defaultColors: [Color] {
        let h: Number = 255
        return [
            Color(components: [255, 255, 255], high: h),  //  0: White
            Color(components: [0, 0, 0], high: h),        //  1: Black
            Color(components: [244, 67, 54], high: h),    //  2: Red
            Color(components: [233, 30, 99], high: h),    //  3: Pink
            Color(components: [156, 39, 176], high: h),   //  4: Purple
            Color(components: [103, 58, 183], high: h),   //  5: Deep Purple
            Color(components: [63, 81, 181], high: h),    //  6: Indigo
            Color(components: [33, 150, 243], high: h),   //  7: Blue
            Color(components: [3, 169, 244], high: h),    //  8: Light Blue
            Color(components: [0, 188, 212], high: h),    //  9: Cyan
            Color(components: [0, 150, 136], high: h),    // 10: Teal
            Color(components: [76, 175, 80], high: h),    // 11: Green
            Color(components: [139, 195, 74], high: h),   // 12: Light Green
            Color(components: [205, 220, 57], high: h),   // 13: Lime
            Color(components: [255, 235, 59], high: h),   // 14: Yellow
            Color(components: [255, 193, 7], high: h),    // 15: Amber
            Color(components: [255, 152, 0], high: h),    // 16: Orange
            Color(components: [255, 87, 34], high: h),    // 17: Deep Orange
            Color(components: [158, 158, 158], high: h),  // 18: Grey
            Color(components: [96, 123, 139], high: h)    // 19: Blue Grey
        ]
    }

    private var colors: [Color] = ColorPalette.defaultColors

    func color(number: Int) -> Color {
        return colors[number % colors.count]
    }

    func set(color: Color, number: Int) {
        colors[number % colors.count] = color
    }

    func reset() {
        colors = ColorPalette.defaultColors
    }

}
