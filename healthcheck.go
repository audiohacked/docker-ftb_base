package main

import (
	// "fmt"
	"github.com/ldilley/minestat/Go/minestat"
	// "minestat"
	"os"
)

func main() {
	minestat.Init("localhost", "25565")
	if minestat.Online {
		// fmt.Println("Online!")
		os.Exit(0)
	} else {
		// fmt.Println("Offline!")
		os.Exit(1)
	}
}
