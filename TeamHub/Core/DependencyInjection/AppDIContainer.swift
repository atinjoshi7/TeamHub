//
//  AppDIContainer.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import Foundation

final class AppDIContainer {
    
    // Core
    private lazy var apiClient: APIClient = URLSessionAPIClient()
    private lazy var coreDataStack: CoreDataStacking = CoreDataStack.shared
    private lazy var networkMonitor: NetworkMonitoring = NetworkMonitor()
    
    // DataSources
    private lazy var remoteDataSource: EmployeeRemoteDataSource =
        EmployeeRemoteDataSourceImpl(apiClient: apiClient)
    
    private lazy var localDataSource: EmployeeLocalDataSource =
        EmployeeLocalDataSourceImpl(stack: coreDataStack)
    
    // Repository
    private lazy var repository: EmployeeRepository =
        EmployeeRepositoryImpl(remote: remoteDataSource,
                               local: localDataSource,
                               network: networkMonitor)
    
//    // UseCases
//    private lazy var getEmployeesUseCase: GetEmployeesUseCase =
//        GetEmployeesUseCaseImpl(repository: repository)
//    
    // ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(getEmployeesFromRepository: repository)
    }
    
    // MARK: - Network Start
    func startNetworkMonitoring() {
        networkMonitor.start()
    }
}
