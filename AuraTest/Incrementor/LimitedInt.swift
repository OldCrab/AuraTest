//
//  LimitedInt.swift
//  AuraTest
//
//  Created by Andrew Vasiliev on 27/03/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

/// Ограниченный сверху целочисленный тип
struct LimitedInt: ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int

    private(set) var intValue: Int
    private var limit: Int = .max

    init(integerLiteral value: IntegerLiteralType) {
        intValue = value
    }

    /// Выставляет верхнюю границу значения, больше нее число не может быть
    ///
    /// - Note: Если текущее значение выше новой верхней границы, то обнуляем его
    ///
    /// - Parameter limit: верхняя граница.
    mutating func set(limit: Int) {
        if intValue > limit {
            intValue = 0
        }

        self.limit = limit
    }

    /// Складывает два значение и сохраняет результат в lhs переменную.
    ///
    /// - Note: Переполнение делает value равным нулю
    ///
    /// - Parameters:
    ///   - lhs: Начальное значение.
    ///   - rhs: Добавляемое значение.
    static func += (lhs: inout LimitedInt, rhs: Int) {
        let (newValue, isOverflowed) = lhs.intValue.addingReportingOverflow(rhs)
        let needToReset = newValue > lhs.limit || isOverflowed

        lhs.intValue = needToReset ? 0 : newValue
    }
}
