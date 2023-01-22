//
//  TapLikedDelegate.swift
//  Navigation
//
//  Created by Constantin on 11.01.2023.
//

import Foundation

protocol TapLikedDelegate: AnyObject {
    func tapLiked(index: Int, numberOfClicks: Int)
}
