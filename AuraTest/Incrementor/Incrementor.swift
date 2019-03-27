//
//  Incrementor.swift
//  AuraTest
//
//  Created by Andrew Vasiliev on 27/03/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import Foundation

protocol IIncrementor: AnyObject {
    /// Метод для получения текущего значения
    ///
    /// - Returns: Возвращает текущее число. В самом начале это ноль.
    func getNumber() -> Int

    /// Увеличивает текущее число на один. После каждого вызова этого
    /// метода getNumber() будет возвращать число на один больше.
    func incrementNumber()

    /// Устанавливает максимальное значение текущего числа.
    /// Когда при вызове incrementNumber() текущее число достигает
    /// этого значения, оно обнуляется, т.е. getNumber() начинает
    /// снова возвращать ноль, и снова один после следующего
    /// вызова incrementNumber() и так далее.
    /// По умолчанию максимум -- максимальное значение int.
    /// Если при смене максимального значения число резко начинает
    /// превышать максимальное значение, то число надо обнулить.
    /// Нельзя позволять установить тут число меньше нуля.
    ///
    /// - Parameter maxValue: новое максимальное значение
    func setMaximumValue(_ maxValue: Int)
}

final class Incrementor {
    private var value: LimitedInt = 0
    private let lock = NSLock()
}

extension Incrementor: IIncrementor {
    func getNumber() -> Int {
        return value.intValue
    }

    func incrementNumber() {
        lock.lock()
        value += 1
        lock.unlock()
    }

    func setMaximumValue(_ maxValue: Int) {
        lock.lock()
        if maxValue >= 0 {
            value.set(limit: maxValue)
        }
        lock.unlock()
    }
}
