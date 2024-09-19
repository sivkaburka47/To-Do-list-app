//
//  TabBarShape.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 14.09.2024.
//

import SwiftUI

struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let curveHeight: CGFloat = 30
        let middle = rect.width / 2
        let cutoutWidth: CGFloat = 100
        let cutoutHeight: CGFloat = 80
        let cornerRadius: CGFloat = 20
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        
        path.addLine(to: CGPoint(x: middle - cutoutWidth / 2, y: rect.minY))
        
        path.addCurve(
            to: CGPoint(x: middle + cutoutWidth / 2, y: rect.minY),
            control1: CGPoint(x: middle - cutoutWidth / 4, y: rect.minY + cutoutHeight),
            control2: CGPoint(x: middle + cutoutWidth / 4, y: rect.minY + cutoutHeight)
        )
        
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        
        path.closeSubpath()
        
        return path
    }
}
