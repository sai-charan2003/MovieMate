//
//  ProcessState.swift
//  MovieMate
//
//  Created by Sai Charan on 15/12/24.
//

import Foundation

enum ProcessState<T> {
    case loading
    case success(T)
    case failure(Error)
}
