//
//  ViewController.swift
//  JoystickUIKit
//
//  Created by Yessen on 2021/12/30.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - Components
    
    private let centerButton = JoystickCenterButton()
    
    private lazy var nextButton = MoveButton(title: .forward, frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private lazy var previousButton = MoveButton(title: .backward, frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    private lazy var buttonsHV = UIStackView()
    
    private var counter: Int = 0
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViews()
        self.createJoystick()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateMoveButtons()
        self.hideAnimation()
    }
    
    // MARK: - UI Layout
    
    private func setViews() {
        self.view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2039215686, blue: 0.2352941176, alpha: 1)
        
        self.createHVButtons()
        
        self.view.addSubview(self.buttonsHV)
        buttonsHV.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.view.addSubview(centerButton)
        centerButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(160)
        }
    }
    
    private func createHVButtons() {
        let views: [UIView] = [self.previousButton, self.nextButton]
        views.forEach { button in
            button.snp.makeConstraints { $0.width.height.equalTo(60) }
        }
        
        self.buttonsHV = UIStackView(arrangedSubviews: views)
        self.buttonsHV.axis = .horizontal
        self.buttonsHV.distribution = .equalSpacing
    }
    
    private func createJoystick() {
        self.centerButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(joystickHold)))
    }
    
    private func animateMoveButtons() {
        let buttons: [UIView] = [self.previousButton, self.nextButton]
        
        buttons.forEach { button in
            button.layoutSubviews()
        }
    }
}

// MARK: - Joystick functions

extension ViewController {
    
    @objc private func joystickHold(gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.showMoveButtons()
        case .ended:
            self.hideMoveButtons()
        case .changed:
            self.userMovedFinger(to: gesture.location(in: self.buttonsHV))
        default:
            break
        }
    }
    
    private func showMoveButtons() {
        self.makeWeakVibration()
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.buttonsHV.transform = .identity
        }
    }
    
    private func userMovedFinger(to location: CGPoint) {
        let hitTest = self.buttonsHV.hitTest(location, with: nil)
        if let selectedButton = hitTest as? MoveButton  {
            UIView.animate(withDuration: 0.5) {
                selectedButton.isSelected
                ? ()
                : self.selectTheButton(button: selectedButton)
            }
        } else {
            self.unselectAllButtons()
        }
    }
    
    private func hideMoveButtons() {
        self.checkForSelectedButtons()
        self.unselectAllButtons()
        self.hideAnimation()
    }
    
    private func checkForSelectedButtons() {
        let buttons:[MoveButton] = [self.previousButton, self.nextButton]
        buttons.forEach { button in
            if button.isSelected {
                button.type == .forward ? self.moveToRight() : self.moveToLeft()
            }
        }
    }
    
    private func unselectAllButtons(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.buttonsHV.subviews.forEach({ (button) in
                guard let joystickButton = button as? MoveButton else { return }
                joystickButton.setUnselected()
            })
        }, completion: completion)
    }
    
    private func hideAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.buttonsHV.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }
    }
    
    private func selectTheButton(button: MoveButton) {
        self.makeWeakVibration()
        button.setSelected()
    }
    
    private func moveToLeft() {
        self.counter = self.counter - 1
        self.centerButton.setTitle("\(self.counter)", for: .normal)
    }
    
    private func moveToRight() {
        self.counter = self.counter + 1
        self.centerButton.setTitle("\(self.counter)", for: .normal)
    }
}
