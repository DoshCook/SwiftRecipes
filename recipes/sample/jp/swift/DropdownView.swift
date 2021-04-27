//
//  DropdownView.swift
//  OKAIMO
//
//  Created by Reona Kubo on 2019/06/21.
//  Copyright © 2019 Reona Kubo. All rights reserved.
//

import UIKit

class DropdownView: NSObject {

    enum CloseType {
        case manual
        case auto
    }

    private let window: UIWindow = {
        let window = UIWindow()
        window.backgroundColor = .clear
        return window
    }()

    private var currentPosition: CGPoint?
    private var originY: CGFloat = 0

    var closeType: CloseType = .auto
    var dismissCompletion: (() -> Void)?

    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        return gesture
    }()

    func present(viewController: UIViewController, frame: CGRect, closeType: CloseType = .auto, animated: Bool, completion: (() -> Void)?, dismissCompletion: (() -> Void)? = nil) {
        let rootViewController = UIViewController()
        rootViewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .fullScreen
        self.closeType = closeType
        self.dismissCompletion = dismissCompletion
        window.rootViewController = rootViewController
        window.frame = frame
        window.frame.size.height += window.safeAreaInsets.top
        if frame.width > UIScreen.main.bounds.width && UIDevice.current.userInterfaceIdiom == .phone {
            window.frame.size.width = UIScreen.main.bounds.width
        }
        window.center.x = UIScreen.main.bounds.width / 2
        window.addGestureRecognizer(panGestureRecognizer)
        window.makeKeyAndVisible()
        originY = frame.origin.y
        if animated {
            window.frame.origin.y = -window.frame.height
            rootViewController.present(viewController, animated: false, completion: completion)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.window.frame.origin.y = frame.origin.y
            }
        } else {
            rootViewController.present(viewController, animated: false, completion: completion)
        }
        if closeType == .auto {
            setupDismissTimer()
        }
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        let completion: () -> Void = {
            self.dismissCompletion?()
            completion?()
            self.window.isHidden = true
        }
        if animated {
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                guard let wself = self else { return }
                wself.window.frame.origin.y = -wself.window.frame.height
            }, completion: { [weak self] isFinished in
                guard isFinished else { return }
                self?.window.rootViewController?.presentedViewController?.dismiss(animated: false, completion: completion)
            })
        } else {
            window.rootViewController?.presentedViewController?.dismiss(animated: false, completion: completion)
        }
    }

    func setupDismissTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let wself = self, wself.panGestureRecognizer.state != .changed else { return }
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UIGestureRecognizer target

extension DropdownView {

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let view = window.rootViewController?.view else { return }
        let location = gesture.location(in: view)
        switch gesture.state {
        case .began:
            currentPosition = location
        case .changed:
            guard let currentPosition = currentPosition else { return }
            let offset = location.y - currentPosition.y
            self.currentPosition = location
            if offset > 0 && window.frame.origin.y >= originY { return }
            window.transform = window.transform.translatedBy(x: 0, y: offset)
        case .ended:
            let velocity = gesture.velocity(in: view)
            currentPosition = nil
            guard velocity.y > -300 else {
                dismiss(animated: true, completion: nil)
                return
            }
            guard closeType == .manual else {
                setupDismissTimer()
                return
            }
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.window.frame.origin.y = self?.originY ?? 0
            }
        default:
            break
        }
    }
}
