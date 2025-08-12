//
//  CandlesTableViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 03.08.2025.
//
import UIKit
import Foundation

// Протокол для уведомления об обновлении свечи
protocol CandleUpdatedDelegate: AnyObject {
    func candleDidUpdate(_ candle: Candle)
    func candleWasCancelled(_ candle: Candle)
}

class CandlesTableViewController: UITableViewController, CandleUpdatedDelegate {
    
    // Массив свечей
    var candles: [Candle] = []
    
    // Константа для ключа хранения
    private static let candlesKey = "savedCandles"
    
    // Обработка нажатия кнопки добавления
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addCandle()
    }
    
    @objc func addCandle() {
        let newCandle = Candle(
            name: "",
            type: "",
            waxVolume: 0,
            waxPricePerKg: 0,
            aromaPercentage: 0,
            aromaPricePer100g: 0,
            containerType: "",
            containerPrice: 0,
            wickType: "",
            wickPrice: 0,
            additionalCosts: 0,
            comment: ""
        )
        
        // Добавляем в массив
        candles.append(newCandle)
        
        // Сохраняем изменения
        saveCandles()
        
        // Обновляем таблицу
        tableView.reloadData()
        
        // Переход на страницу редактирования созданной свечи
        performSegue(withIdentifier: "editCandleSegue", sender: newCandle)
    }
    
    // Загрузка данных при старте
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Загружаем сохраненные данные
        loadCandles()
        
        // Регистрируем ячейку таблицы
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CandleCell")
    }
    
    // Метод для сохранения данных
    private func saveCandles() {
        guard let encodedData = try? JSONEncoder().encode(candles) else {
            print("Ошибка кодирования данных")
            return
        }
        
        UserDefaults.standard.set(encodedData, forKey: CandlesTableViewController.candlesKey)
    }
    
    // Метод для загрузки данных
    private func loadCandles() {
        if let savedData = UserDefaults.standard.data(forKey: CandlesTableViewController.candlesKey),
           let loadedCandles = try? JSONDecoder().decode([Candle].self, from: savedData) {
            candles = loadedCandles
        } else {
            candles = []
        }
    }
    
    // Обработка нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCandle = candles[indexPath.row]
        performSegue(withIdentifier: "showDetailSegue", sender: selectedCandle)
    }
    
    // Подготовка к переходу
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            guard let destination = segue.destination as? CandleDetailViewController,
                  let candle = sender as? Candle else {
                return
            }
            destination.delegate = self
            destination.candle = candle
        } else if segue.identifier == "editCandleSegue" {
            guard let destination = segue.destination as? EditCandleViewController,
                  let candle = sender as? Candle else {
                print("Ошибка передачи данных")
                return
            }
            destination.delegate = self
            destination.candle = candle
        }
    }
    
    // Метод протокола для обновления свечи
    func candleDidUpdate(_ candle: Candle) {
        if let index = candles.firstIndex(where: { $0.id == candle.id }) {
            candles[index] = candle
            saveCandles()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Продолжение класса CandlesTableViewController

    // Метод для отмены создания/редактирования (продолжение)
    func candleWasCancelled(_ candle: Candle) {
        if let index = candles.firstIndex(where: { $0.id == candle.id }) {
            candles.remove(at: index)
            saveCandles()
            tableView.reloadData()
        }
    }

    // Методы таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CandleCell",
            for: indexPath
        )
        
        let candle = candles[indexPath.row]
        cell.textLabel?.text = "\(candle.name) | \(candle.aromaVolume)г | \(candle.waxVolume)г | \(candle.cost)₽"
        return cell
    }

    // Обработка удаления ячейки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            candles.remove(at: indexPath.row)
            saveCandles()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Деинициализация
    deinit {
        // Можно добавить дополнительную очистку, если потребуется
    }
    }
