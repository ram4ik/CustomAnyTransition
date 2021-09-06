//
//  ContentView.swift
//  CustomAnyTransition
//
//  Created by ramil on 06.09.2021.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    
    static var rotating: AnyTransition {
        return modifier(active: RotateViewModifier(rotation: 180), identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        return modifier(active: RotateViewModifier(rotation: rotation), identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotateOn: AnyTransition {
        return asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading)
        )
    }
}

struct ContentView: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Click Me!")
                .padding()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
