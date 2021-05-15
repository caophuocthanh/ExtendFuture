//
//  ExtendFuture.swift
//  ExtendFuture
//
//  Created by Cao Phuoc Thanh on 15/05/2021.
//

import Combine

public extension Future {
    
    // Then
    func then<OtherOutput, OtherFailure>(_ block: @escaping (Output) -> Future<OtherOutput, OtherFailure>) -> Future<OtherOutput, OtherFailure> {
        return Future<OtherOutput, OtherFailure>{ promise in
            let _ = self.sink { (completed) in
                switch completed {
                case .finished:
                    break
                case .failure(let error):
                    promise(.failure(error as! OtherFailure))
                }
            } receiveValue: { (value) in
                let nextFuture = block(value)
                let _ = nextFuture.sink { (completed) in
                    switch completed {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { (value) in
                    promise(.success(value))
                }
                
            }
        }
    }
    
    // Await
    func await() throws -> Output {
        let semophore = DispatchSemaphore(value: 0)
        var value: Output?
        var error: Error?
        
        let _ = self.sink { (result) in
            switch result {
            case .failure(let _error):
                error = _error
            default: break
            }
            semophore.signal()
        } receiveValue: { (v) in
            value = v
        }
        if let error = error {
            throw error
        }
        return value!
    }
}
