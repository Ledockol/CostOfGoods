//
//  FiguresTableViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 12.08.2025.
//

import UIKit
import Foundation

// Протокол для уведомления об обновлении фигуры
protocol FigureUpdatedDelegate: AnyObject {
    func figureDidUpdate(_ figure: Figure)
    func figureWasCancelled(_ figure: Figure)
}

class FiguresTableViewController: UITableViewController, FigureUpdatedDelegate {
    
    // Массив фигур
    var figures: [Figure] = []
    
    // Константа для ключа хранения
    private static let figuresKey = "savedFigures"
    

    // Обработка нажатия кнопки добавления
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addFigure()
    }
    
    @objc func addFigure() {
        let newFigure = Figure(
            name: "",
            material: "",
            weight: 0,
            materialPricePerKg: 0,
            additionalCosts: 0,
            comment: ""
        )
        // Добавляем в массив
        figures.append(newFigure)
        
        // Сохраняем изменения
        saveFigures()
        
        // Обновляем таблицу
        tableView.reloadData()
        
        // Переход на страницу редактирования созданной фигуры
        performSegue(withIdentifier: "editFigureSegue", sender: newFigure)
    }
    
    // Загрузка данных при старте
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Загружаем сохраненные данные
        loadFigures()
        
        // Регистрируем ячейку таблицы
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FigureCell")
    }
    
    // Метод для сохранения данных
    private func saveFigures() {
        guard let encodedData = try? JSONEncoder().encode(figures) else {
            print("Ошибка кодирования данных")
            return
        }
        
        UserDefaults.standard.set(encodedData, forKey: FiguresTableViewController.figuresKey)
    }
    
    // Метод для загрузки данных
    private func loadFigures() {
        if let savedData = UserDefaults.standard.data(forKey: FiguresTableViewController.figuresKey),
           let loadedFigures = try? JSONDecoder().decode([Figure].self, from: savedData) {
            figures = loadedFigures
        } else {
            figures = []
        }
    }
    
    // Обработка нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFigure = figures[indexPath.row]
        performSegue(withIdentifier: "showDetailFiguresSegue", sender: selectedFigure)
    }
    
    // Подготовка к переходу
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFiguresSegue" {
            guard let destination = segue.destination as? FigureDetailViewController,
                  let figure = sender as? Figure else {
                return
            }
            destination.delegate = self
            destination.figure = figure
        } else if segue.identifier == "editFigureSegue" {
            guard let destination = segue.destination as? EditFigureViewController,
                  let figure = sender as? Figure else {
                print("Ошибка передачи данных")
                return
            }
            destination.delegate = self
            destination.figure = figure
        }
    }
    
    // Метод протокола для обновления фигуры
    func figureDidUpdate(_ figure: Figure) {
        if let index = figures.firstIndex(where: { $0.id == figure.id }) {
            figures[index] = figure
            saveFigures()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    


    // Метод для отмены создания/редактирования
    func figureWasCancelled(_ figure: Figure) {
        if let index = figures.firstIndex(where: { $0.id == figure.id }) {
            figures.remove(at: index)
            saveFigures()
            tableView.reloadData()
        }
    }

    // Методы таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return figures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FigureCell",
            for: indexPath
        )
        
        let figure = figures[indexPath.row]
        cell.textLabel?.text = "\(figure.name) | \(figure.cost)₽"
        return cell
    }

    // Обработка удаления ячейки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            figures.remove(at: indexPath.row)
            saveFigures()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Деинициализация
    deinit {

    }
}
