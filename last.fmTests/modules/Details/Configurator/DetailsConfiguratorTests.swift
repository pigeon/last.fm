//
//  DetailsDetailsConfiguratorTests.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import XCTest
@testable import last_fm


class DetailsModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = DetailsViewControllerMock()
        let configurator = DetailsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "DetailsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is DetailsPresenter, "output is not DetailsPresenter")

        let presenter: DetailsPresenter = viewController.output as! DetailsPresenter
        XCTAssertNotNil(presenter.view, "view in DetailsPresenter is nil after configuration")

        let interactor: DetailsInteractor = presenter.interactor as! DetailsInteractor
        XCTAssertNotNil(interactor.output, "output in DetailsInteractor is nil after configuration")
    }

    class DetailsViewControllerMock: DetailsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
