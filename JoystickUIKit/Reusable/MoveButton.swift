//
//  MoveButton.swift
//  JoystickUIKit
//
//  Created by Yessen on 2021/12/30.
//

import UIKit

public enum MoveButtonType: String {
    case forward = "▶︎"
    case backward = "◀︎"
}

final class MoveButton: UIButton {
    
    public let type: MoveButtonType
    
    // MARK: - constructors
    
    init(title: MoveButtonType, frame: CGRect) {
        self.type = title
        super.init(frame: frame)
        self.setViews(title: title.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting the view
    
    private func setViews(title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.setTitleColor(.black, for: .normal)
    }
    
    // MARK: - selection/unselection
    
    public func setSelected() {
        self.titleLabel?.font = .systemFont(ofSize: 40)
        self.isSelected = true
    }
    
    public func setUnselected() {
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.isSelected = false
    }
}
