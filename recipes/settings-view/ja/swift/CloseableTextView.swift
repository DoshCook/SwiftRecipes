//
//  CloseableTextView.swift
//  OKAIMO
//
//  Created by Reona Kubo on 2019/07/24.
//  Copyright © 2019 Reona Kubo. All rights reserved.
//

import UIKit

final class CloseableTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupToolbar()
    }

    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.backgroundColor = .white
        toolbar.isTranslucent = true
        let closeButton = UIBarButtonItem(title: R.string.localizable.done(), style: .done, target: self, action: #selector(onTapCloseButton(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }

    @objc func onTapCloseButton(_ sender: UIButton) {
        resignFirstResponder()
    }
}
