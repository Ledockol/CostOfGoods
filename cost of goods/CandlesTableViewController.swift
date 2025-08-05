//
//  CandlesTableViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 03.08.2025.
//
import UIKit

class CandlesTableViewController: UITableViewController {
    
    // Массив свечей
    var candles: [Candle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Свечи"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CandleCell")

    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        //Првоерка нажатия кнопки
        print("Кнопка + нажата")
        addCandle()
    }
    // Обработка нажатия кнопки добавления
    @objc func addCandle() {
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
        
        // Проверка создания свечи
        print("Создана новая свеча: \(newCandle.name)")
        
        // Добавляем в массив
        candles.append(newCandle)
        
        // Обновляем таблицу
        tableView.reloadData()
        
        //Переход на страницу редактирования созданной свечи
        performSegue(withIdentifier: "editCandleSegue", sender: newCandle)
    }
    
    // Переход
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCandleSegue" {
            guard let destination = segue.destination as? EditCandleViewController,
                  let candle = sender as? Candle else {
                print("Ошибка передачи данных")
                return
            }
            //Фиксация страницы редактирования
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
        cell.textLabel?.text = "\(candle.name) | \(candle.aromaVolume)г | \(candle.waxVolume)г | \(candle.cost)₽"
        return cell
    }
    
}
