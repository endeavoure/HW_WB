package main

import (
	"fmt"
	"unsafe"
)

func main() {

	m := [0]int64{}
	n := struct {
	}{}
	fmt.Println("Pointer", uintptr(unsafe.Pointer(&m)) == uintptr(unsafe.Pointer(&n)))

}

/*ZeroBase — это единственная выделенная область памяти, которая используется для всех значений нулевого размера.

Такие значения не занимают реальной памяти, так как их размер равен 0.
Но для соответствия спецификации языка они должны иметь адрес. Поэтому компилятор предоставляет фиктивный адрес для таких объектов.
Все нулевые значения (например, пустые структуры или массивы с длиной 0) получают один и тот же адрес.
Это сделано для экономии ресурсов и упрощения реализации.
m := [0]int64{} — создается массив длины 0, который не хранит никаких данных.
n := struct{}{} — создается пустая структура, которая также не занимает памяти.
uintptr(unsafe.Pointer(&m)) == uintptr(unsafe.Pointer(&n)):
Здесь сравниваются адреса m и n.
Поскольку оба объекта нулевого размера, Go назначает им один и тот же адрес — адрес zeroBase.
Поэтому результат сравнения будет true.*/