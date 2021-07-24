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

    func test_changeValidationFirstText() {
        XCTContext.runActivity(named: "firstTextがバリデーションに成功する場合") { _ in
            setup()
            fakeModel.validateResult = .success(String(10))
            // FakeModelは.validateResultを成功パターンで10をnotificationに送る
            viewModel.numbersInput(text: "10", isOn: false, textState: .first)

            XCTAssertEqual("10", firstText)  // notificationに10が来た場合、firstTextに10を渡せているかのテスト

            clean()
        }

        XCTContext.runActivity(named: "firstTextがバリデーションに失敗する場合") { _ in
            XCTContext.runActivity(named: "textがnilの場合") { _ in
                setup()

                fakeModel.validateResult = .failure(.invalidNil)

                viewModel.numbersInput(text: nil, isOn: false, textState: .first)

                XCTAssertEqual("Nil", firstText)

                clean()
            }

            XCTContext.runActivity(named: "textが空の場合") { _ in
                setup()

                fakeModel.validateResult = .failure(.invalidEnpty)

                viewModel.numbersInput(text: "", isOn: false, textState: .first)

                XCTAssertEqual("Enpty", firstText)

                clean()
            }

            XCTContext.runActivity(named: "textが数字でない場合") { _ in
                setup()

                fakeModel.validateResult = .failure(.invalidNotInt)

                viewModel.numbersInput(text: "文字列", isOn: false, textState: .first)

                XCTAssertEqual("NotInt", firstText)

                clean()
            }

        }

    }

    func test_changeValidationSecondText() {
        XCTContext.runActivity(named: "secondTextがバリデーションに成功する場合") { _ in
            setup()
            fakeModel.validateResult = .success(String(-20))
            // -20がfakeModelから返ってきて、その-20をpostするために呼び出す
            viewModel.numbersInput(text: "-20", isOn: true, textState: .second)

            XCTAssertEqual("-20", secondText)

            clean()
        }

        XCTContext.runActivity(named: "secondTextがバリデーションに失敗する場合") { _ in
            XCTContext.runActivity(named: "textがnilの場合") { _ in
                setup()

                fakeModel.validateResult = .failure(.invalidNil)

                viewModel.numbersInput(text: nil, isOn: false, textState: .second)

                XCTAssertEqual("Nil", secondText)

                clean()
            }

            XCTContext.runActivity(named: "textが空の場合") { _ in
                setup()

                fakeModel.validateResult = .failure(.invalidEnpty)

                viewModel.numbersInput(text: "", isOn: false, textState: .second)

                XCTAssertEqual("Enpty", secondText)

                clean()
            }

            XCTContext.runActivity(named: "textが数字でない場合") { _ in
                setup()

                fakeModel.validateResult = .failure(.invalidNotInt)

                viewModel.numbersInput(text: "文字列", isOn: false, textState: .second)

                XCTAssertEqual("NotInt", secondText)

                clean()
            }
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
