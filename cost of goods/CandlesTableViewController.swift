//
//  CandlesTableViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 03.08.2025.
//

import UIKit

class CandlesTableViewController: UITableViewController {
    
    // Массив свечей
    var candles: [Candle] = [
        // Существующие свечи
        Candle(
            name: "Свеча 1",
            type: "Соевая",
            waxVolume: 200,
            waxPricePerKg: 800,
            aromaPercentage: 7,
            aromaPricePer100g: 200,
            containerType: "Стеклянная банка",
            containerPrice: 150,
            wickType: "Хлопковый",
            wickPrice: 30,
            additionalCosts: 50,
            comment: "Базовая свеча"
        ),
        
        Candle(
            name: "Свеча 2",
            type: "Парафиновая",
            waxVolume: 300,
            waxPricePerKg: 600,
            aromaPercentage: 8,
            aromaPricePer100g: 250,
            containerType: "Керамическая чаша",
            containerPrice: 200,
            wickType: "Деревянный",
            wickPrice: 40,
            additionalCosts: 70,
            comment: "Ароматическая свеча"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Свечи"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CandleCell")
//        
//        // Убедимся, что кнопка добавления настроена
//                if navigationItem.rightBarButtonItem == nil {
//                    navigationItem.rightBarButtonItem = UIBarButtonItem(
//                        barButtonSystemItem: .add,
//                        target: self,
//                        action: #selector(addCandle)
//                    )
//                }
    }
    
    // Обработка нажатия кнопки добавления
    @objc func addCandle() {
        
        print("Кнопка создания нажата") // Добавьте это для проверки
        // Создаем новый экземпляр свечи с базовыми параметрами
        let newCandle = Candle(
            name: "Новая свеча",
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
        
        // Обновляем таблицу
        tableView.reloadData()
        
        // Переходим к редактированию новой свечи
        performSegue(withIdentifier: "editCandleSegue", sender: newCandle)
    }
    
    // Подготовка к переходу
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCandleSegue" {
            guard let destination = segue.destination as? EditCandleViewController,
                  let candle = sender as? Candle else { return }
            destination.candle = candle
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
        cell.textLabel?.text = "\(candle.name) | \(candle.waxVolume)г | \(candle.cost)₽"
        return cell
    }
    
}
