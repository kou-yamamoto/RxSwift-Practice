//
//  ViewController.swift
//  RxSwiftDemoApp
//
//  Created by kou yamamoto on 2021/02/11.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tappedPlaceLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let input = Input(rightButton: rightButton.rx.tap.asObservable(), centerButton: centerButton.rx.tap.asObservable(), leftButton: leftButton.rx.tap.asObservable())
        viewModel.setup(input: input)
        viewModel.tappedPlaceLabel
            .subscribe { [weak self] in
                self?.tappedPlaceLabel.text = $0.element
            }.disposed(by: disposeBag)
    }
}
