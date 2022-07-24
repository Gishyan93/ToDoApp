//
//  ColorPickerView.swift
//  ToDoApp
//
//  Created by Tigran Gishyan on 21.07.22.
//

import UIKit

struct ColorPickerViewData {
    var color: UIColor
    var isSelected: Bool
}

class ColorPickerView: UIView {
    var button: UIButton!
    var onColorSelection: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func set(data: ColorPickerViewData) {
        self.backgroundColor = data.color
        if data.isSelected {
            layer.borderWidth = 5
            layer.borderColor = UIColor.darkGray.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
    
    @objc func buttonPressed() {
        onColorSelection?()
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.width/2
    }
}
// MARK: - Layout
private extension ColorPickerView {
    func commonInit() {
        initViews()
    }
    
    func initViews() {
        button = UIButton()
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        button.addTarget(
            self,
            action: #selector(buttonPressed),
            for: .touchUpInside
        )
    }
}
