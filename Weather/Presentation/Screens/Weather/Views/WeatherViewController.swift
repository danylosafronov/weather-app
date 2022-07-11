//
//  WeatherViewController.swift
//  Weather
//
//  Created by Danylo Safronov on 07.07.2022.
//

import Combine
import CoreLocation
import UIKit

final class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    private lazy var innerView = WeatherView()
    private lazy var locationManager = CLLocationManager()
    private let viewModel: WeatherViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController lifecycle
    
    override func loadView() {
        view = innerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        observe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load()
        startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopUpdatingLocation()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        configureLocationManager()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    // MARK: - Observers
    
    private func observe() {
        observeViewModelData()
    }
    
    private func observeViewModelData() {
        Publishers.CombineLatest3(viewModel.$locationForecast, viewModel.$hourlyForecast, viewModel.$dailyForecast)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locationForecast, hourlyForecasts, dailyForecasts in
                self?.viewModelDataSourceDidChange(
                    currentForecasts: locationForecast,
                    hourlyForecasts: hourlyForecasts,
                    dailyForecasts: dailyForecasts
                )
            }
            .store(in: &cancellable)
    }
    
    // MARK: - WeatherViewController lifecycle
    
    private func viewModelDataSourceDidChange(
        currentForecasts: LocationForecasts?,
        hourlyForecasts: LocationForecasts?,
        dailyForecasts: LocationForecasts?
    ) {
        innerView.apply(
            locationForecast: currentForecasts,
            hourlyForecasts: hourlyForecasts,
            dailyForecasts: dailyForecasts
        )
    }
    
    private func locationAuthorizationStatusDidChange(_ status: CLAuthorizationStatus) {
        if status == .denied {
            locationAuthorizationStatusDidDenied()
        }
    }
    
    private func locationAuthorizationStatusDidDenied() {
        showLocationPermissionRequiredAlert()
    }
    
    private func locationDidChange(_ location: CLLocation) {
        viewModel.load(
            coordinates: .init(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        )
    }
    
    // MARK: - Logic
    
    private func showLocationPermissionRequiredAlert() {
        let alert = makeLocationPermissionRequiredAlert()
        present(alert, animated: true)
    }
    
    private func makeLocationPermissionRequiredAlert() -> UIAlertController {
        let alertController = UIAlertController(
            title: "Location Permission Required",
            message: "Please enable location permissions in settings.",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let openSettingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let url = URL(string:UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(openSettingsAction)
        
        return alertController
    }
    
    private func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationAuthorizationStatusDidChange(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationDidChange(location)
    }
}
