package main

import (
	"fmt"
)

func evenSum() {
	numbers := []int{3, 5, 7, 2, 7, 8, 6, 4, 7, 0, 1, 7, 4, 8, 10, 3, 6, 8, 5, 4, 12, 3}
	var pointer *int
	cnt := 0

	for index, value := range numbers {
		pointer = &numbers[index]

		if value % 2 == 0 {
			*pointer = 1
		}

		cnt += *pointer
	}

	fmt.Println("Задача 1. Сумма в новом слайсе:", cnt)
}

func pointerSlice() {
	numbers := []int{1, 10, 2, 5, 4, 4, 3, 5, 7, 8, 8, 1, 3, 7, 9, 10, 1, 9, 5, 3, 6, 6}
	var pointer *int

	for index, _ := range numbers {
		pointer = &numbers[index]
		*pointer += 5
	}

	fmt.Println("Задача 2. Изменённый слайс:", numbers)
}

func evenExtremum() {
	numbers := []int{8, 44, 3, 5, 11, 8, 2, 10, 6, 77, 15, 12}
	pointerMax := &numbers[0]
	pointerMin := &numbers[0]

	for i := 1; i < len(numbers); i++ {
		if numbers[i] >= *pointerMax && numbers[i] % 2 == 0 {
			pointerMax = &numbers[i]
		}
		if numbers[i] < *pointerMin && numbers[i] % 2 == 0 {
			pointerMin = &numbers[i]
		}
	}

	fmt.Println("Задача 3. Максимальное значение слайса, которое делится на 2:", *pointerMax)
	fmt.Println("\t  Минимальное значение слайса, которое делится на 2:", *pointerMin)
}




func main() {
	evenSum()
	pointerSlice()
	evenExtremum()
}