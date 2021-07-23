//
//  SalonKadai3Tests.swift
//  SalonKadai3Tests
//
//  Created by 坂本龍哉 on 2021/07/14.
//

import XCTest
@testable import SalonKadai3

class FakeModel: ModelProtocol {
    var validateResult: Result<String, TextError>?
    var calculateResult: Result<String, CalculateError>?

    func validate(text: String?, isOn: Bool) -> Result<String, TextError> {
        guard let validateResult = validateResult else { fatalError("validationResult has not been set.") }

        return validateResult
    }

    func calculate(firstLabel: String?, secondLabel: String?) -> Result<String, CalculateError> {
        guard let calculateResult = calculateResult else { fatalError("calculateResult has not been set.") }

        return calculateResult
    }
}

class SalonKadai3Tests: XCTestCase {
    private var firstText: String?
    private var secondText: String?

    private let notificationCenter = NotificationCenter()
    private var fakeModel: FakeModel!
    private var viewModel: ViewModel!

    func test_changeValidationText() {
        XCTContext.runActivity(named: "バリデーションに成功する場合") { _ in
            setup()
            fakeModel.validateResult = .success(String(10))

            viewModel.numbersInput(text: "10", isOn: false, textState: .first) // FakeModelは.validateResultを成功パターンで10をnotificationに送る

            XCTAssertEqual("10", firstText)  // notificationに10が来た場合、firstTextに10を渡せているかのテスト

            clean()
        }
    }

    @objc private func updateFirstText(notification: Notification) {
        guard let text = notification.object as? String else {
            XCTFail("Fail to convert text.")
            fatalError()
        }
        firstText = text
    }

    @objc private func updateSecondText(notification: Notification) {
        guard let text = notification.object as? String else {
            XCTFail("Fail to convert text.")
            fatalError()
        }
        secondText = text
    }

    private func setup() {
        fakeModel = FakeModel()
        viewModel = ViewModel(notificationCenter: notificationCenter,
                              model: fakeModel)

        notificationCenter.addObserver(self,
                                       selector: #selector(updateFirstText),
                                       name: .inputFirstText,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(updateSecondText),
                                       name: .inputSecondText,
                                       object: nil)

    }

    private func clean() {
        fakeModel = nil
        viewModel = nil
    }
}
