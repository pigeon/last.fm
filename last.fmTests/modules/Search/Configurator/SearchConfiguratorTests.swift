//
//  SearchSearchConfiguratorTests.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//
//

import XCTest
@testable import last_fm


class SearchModuleConfiguratorTests: XCTestCase {

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
        let viewController = SearchViewControllerMock()
        let configurator = SearchModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SearchViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SearchPresenter, "output is not SearchPresenter")

        let presenter: SearchPresenter = viewController.output as! SearchPresenter
        XCTAssertNotNil(presenter.view, "view in SearchPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SearchPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SearchRouter, "router is not SearchRouter")

        let interactor: SearchInteractor = presenter.interactor as! SearchInteractor
        XCTAssertNotNil(interactor.output, "output in SearchInteractor is nil after configuration")
    }

    class SearchViewControllerMock: SearchViewController {
    }
}
