//
//  MoveButton.swift
//  JoystickUIKit
//
//  Created by Yessen on 2021/12/30.
//

import UIKit

final class MoveButton: UIButton {
    
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        self.setViews(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews(title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.setTitleColor(.black, for: .normal)
    }
    
    public func setSelected() {
        self.titleLabel?.font = .systemFont(ofSize: 40)
    }
    
    public func setUnselected() {
        self.titleLabel?.font = .systemFont(ofSize: 30)
    }
}
