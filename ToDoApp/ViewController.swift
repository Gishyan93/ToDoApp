//
//  ViewController.swift
//  ToDoApp
//
//  Created by Tigran Gishyan on 21.07.22.
//

import UIKit

struct ColorsData {
    var id: Int
    var color: UIColor
    
    static var colors: [ColorsData] = [
        ColorsData(id: 0, color: .red),
        ColorsData(id: 1, color: .blue),
        ColorsData(id: 2, color: .brown),
        ColorsData(id: 3, color: .cyan),
        ColorsData(id: 4, color: .yellow),
        ColorsData(id: 5, color: .black),
        ColorsData(id: 6, color: .green),
        ColorsData(id: 7, color: .magenta)
    ]
}

class ViewController: UIViewController {

    var stackView: UIStackView!
    var textField: UITextField!
    var textView: UITextView!
    var saveButton: UIButton!
    var colorStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        createColorViews(with: 0)
    }
    
    func createColorViews(with selectedId: Int) {
        // Due to `createColorViews` could called several times, need to `remove` and `add` appropriate subviews to stack view.
        colorStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        for item in ColorsData.colors {
            // MARK: - Instanciating ColorPickerView
            let colorView = ColorPickerView()
//            if item.id == selectedId {
//                colorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            } else {
//                colorView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//            }
            
            
            // MARK: - Setting Data to ColorPickerView
            colorView.set(
                data: ColorPickerViewData(
                    color: item.color,
                    isSelected: selectedId == item.id
                )
            )
            // Using `[weak self]` capture list to avoid retain cycle
            colorView.onColorSelection = { [weak self] in
                self?.createColorViews(with: item.id)
            }
            colorStackView.addArrangedSubview(colorView)
        }
    }
}

// MARK: - Layout
private extension ViewController {
    func initViews() {
        initStackView()
        initTextField()
        initTextView()
        initSaveButton()
        initColorStackView()
        constructHierarchy()
        activateConstraints()
    }
    
    func initStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func initColorStackView() {
        colorStackView = UIStackView()
        colorStackView.axis = .horizontal
        colorStackView.spacing = 12
        colorStackView.distribution = .fillEqually
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func initTextField() {
        textField = UITextField()
        textField.placeholder = "Name"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func initTextView() {
        textView = UITextView()
        textView.text = "Test"
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 12
        textView.layer.borderColor = UIColor.black.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func initSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = .systemBlue
        saveButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constructHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(colorStackView)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            textField.heightAnchor.constraint(equalToConstant: 50),
            textView.heightAnchor.constraint(equalToConstant: 130),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
