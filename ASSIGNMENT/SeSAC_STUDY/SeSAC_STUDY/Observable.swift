//
//  Observable.swift
//  SeSAC_STUDY
//
//  Created by 김진영 on 2021/12/29.
//

import Foundation

class Observable<T> {
    private var listener: ( (T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
            print(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure:  @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
