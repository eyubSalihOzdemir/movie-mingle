//
//  LottieView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 4.07.2023.
//

import SwiftUI
import Lottie

enum LottieAnimation: String {
    case loading = "loading"
}

struct LottieView: UIViewRepresentable {
    var lottieAnimation: LottieAnimation
    @Binding var playing: Bool
    
    let animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        let uiView = UIView(frame: .zero)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])
        
        DotLottieFile.loadedFrom(url: Bundle.main.url(forResource: lottieAnimation.rawValue, withExtension: "lottie")!) { result in
            switch result {
            case .success(let success):
                animationView.loadAnimation(from: success)
                animationView.loopMode = .loop
                animationView.contentMode = .scaleAspectFit
                animationView.stop()
            case .failure(let failure):
                print("Failure while loading Lottie animation!")
                print(failure)
            }
        }

        return uiView
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        if playing {
            context.coordinator.parent.animationView.play()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                context.coordinator.parent.animationView.stop()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

    class Coordinator: NSObject {
        var parent: LottieView

        init(_ parent: LottieView) {
            self.parent = parent
        }
    }
}
