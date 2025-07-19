//
//  AppStep.swift
//  DonationApp
//
//  Created by ketan patel on 6/25/25.
//


import Foundation

enum AppStep {
    case selectAmount
    case confirm(amount: Int)
    case thankYou
    case paymentError
}
