//
//  Observable.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import Foundation

class Observable<T> {
    private var listener: ( (T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
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
