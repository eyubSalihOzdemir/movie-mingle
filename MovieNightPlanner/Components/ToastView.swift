//
//  ToastView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 15.07.2023.
//

import SwiftUI

struct ToastView: View {
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            
            Text(message)
                .font(.caption)
                .foregroundColor(Color.primary)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(maxWidth: width)
        .background(Color(uiColor: UIColor.systemBackground))
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                       // .offset(y: 32)
                }
                .animation(.spring(), value: toast)
            )
            .onChange(of: toast) { newValue in
                showToast()
            }
    }
    
    @ViewBuilder  func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                ToastView(style: toast.style, message: toast.message, width: toast.width) {
                    dismissToast()
                }
                
                Spacer()
            }
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task  = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(style: .success, message: "Successfully signed in") {
            //
        }
    }
}
