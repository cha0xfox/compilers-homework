# Лабораторная работа №1"
## Создание лексического анализатора

Студент: Скворцов Иван Максимович

Группа: М8О-107-22

---

## Задание
### Вариант 3
Калькулятор вычисляет битовые арифметические выражения выражения. Символьными литералими в данном случае являются целые числа в диапазоне от 0 до 2^32 в шестнадцатиричной записи, перед которыми идёт префикс 0x (класс токена ILIT). Возможные действия над аргументами: побитовая конъюнкция & (класс токена BAND), побитовая дизъюнкция | (класс токена BOR), побитовая строгая дизъюнкция ^ (класс токена BXOR), побитовое отрицание (класс токена BNOT).

---

## Компиляция

Prerequisites:
```
flex 2.6.4
gcc version 11.3.0
```
Проверялось под: _Linux 5.15.0-67-generic Ubuntu_

Бинарный файл после компиляции находится в папке __bin__.

```bash
make # compile
# Для ребилда и очистки
make rebuild  # rebuild a binary
make clean # clean 
```

Запуск:
```bash
Usage: ./lab1.out (optional):<filename>
```

Структура папок:
```
compilers-homework
 ┣ src
 ┃ ┗ lab1.l
 ┣ tests
 ┃ ┗ tests.txt
 ┣ .gitignore
 ┣ Makefile
 ┗ README.md
```