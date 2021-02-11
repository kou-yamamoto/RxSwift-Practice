//
//  ViewModel.swift
//  RxSwiftDemoApp
//
//  Created by kou yamamoto on 2021/02/11.
//

import UIKit
import RxSwift
import RxCocoa

struct Input {
    let rightButton: Observable<Void>
    let centerButton: Observable<Void>
    let leftButton: Observable<Void>
}

protocol ViewModelType {
    func setup(input: Input)
}

class ViewModel: ViewModelType  {
    
    var tappedPlaceLabel: Observable<String> {
        return buttonRelay.asObservable() //RelayをObservableに変換したものがリターンされる
    }
    
    let buttonRelay = PublishRelay<String>()
    let disposeBag = DisposeBag()
    
    func setup(input: Input) {
        input.rightButton
            .subscribe(onNext: { [weak self] in
                self?.rightButtonDidTapped()
            }).disposed(by: disposeBag)
        
        input.centerButton
            .subscribe(onNext: { [weak self] in
                self?.centerButtonDidTapped()
            }).disposed(by: disposeBag)
        
        input.leftButton
            .subscribe(onNext: { [weak self] in
                self?.leftButtonDidTapped()
            }).disposed(by: disposeBag)
    }
    
    private func rightButtonDidTapped() {
        buttonRelay.accept("右のボタンをクリックしました")
    }
    
    func centerButtonDidTapped() {
        buttonRelay.accept("真ん中のボタンをクリックしました")
    }
    
    func leftButtonDidTapped() {
        buttonRelay.accept("左のボタンをクリックしました")
    }
}
