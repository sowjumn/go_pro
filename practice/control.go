package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Please provide a command line argument")
		return
	}
	argument := os.Args[1]
	myInt, err := strconv.Atoi(argument)
	if err != nil {
		fmt.Println(err)
	}

	switch argument {
	case "0":
		fmt.Println("Zero!")
	case "1":
		fmt.Println("One!")
	case "2", "3", "4":
		fmt.Println("2 or 3 or 4")
		fallthrough
	default:

		fmt.Printf("Value is: %d", myInt)
	}
}
