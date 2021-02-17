package main

import (
	"embed"
	"fmt"
	"log"
	"net/http"
	"os/exec"
	"runtime"
)

//go:embed *.png
//go:embed *.png.import
//go:embed *.js
//go:embed *.pck
//go:embed *.wasm
//go:embed *.html

var static embed.FS

func main() {
	http.Handle("/", http.FileServer(http.FS(static)))
	log.Fatal(http.ListenAndServe(":8080", nil))
	openbrowser("localhost:8080")
}

func openbrowser(url string) {
	var err error

	switch runtime.GOOS {
	case "linux":
		err = exec.Command("xdg-open", url).Start()
	case "windows":
		err = exec.Command("cmd", "/C", "start", url).Run()
	case "darwin":
		err = exec.Command("open", url).Start()
	default:
		err = fmt.Errorf("unsupported platform")
	}
	if err != nil {
		log.Fatal(err)
	}

}
