package main

import (
	"encoding/json"
	"encoding/xml"
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"strconv"
	"time"
)

type Relay struct {
	Name string `json:"Name" xml:"Name"`
	Value string `json:"Value" xml:"Value"`
}

type AutoReboot struct {
	RebootsNumber string `json:"RebootsNumber" xml:"RebootsNumber"`
	LastReboot string `json:"LastReboot" xml:"LastReboot"`
}

type Device struct {
	Name string `json:"Name" xml:"Name"`
	Mac string `json:"Mac" xml:"MAC"`
	Date string `json:"Date" xml:"Date"`
	Time string `json:"Time" xml:"Time"`
}
type CurrentState struct {
	Output [16]Relay `json:"Output"`
	AutoReboot AutoReboot `json:"Auto-Reboot" xml:"Auto-Reboot"`
	Device Device `json:"Device" xml:"Device"`
}

type Reply struct {
	CurrentState CurrentState `json:"CurrentState" xml:"CurrentState"`
}

var data Reply

func main() {
	data.CurrentState.AutoReboot.RebootsNumber = "0"
	data.CurrentState.AutoReboot.LastReboot = "-"
	data.CurrentState.Device.Name = "SD_IP-16R-MQ"
	data.CurrentState.Device.Mac = "E8:EA:DA:00:31:6B"
	for  i := 0; i < 16; i++ {
		data.CurrentState.Output[i].Name = "RELAY" + strconv.Itoa(i+1)
		data.CurrentState.Output[i].Value = "0"
	}
	net := mux.NewRouter()
	net.HandleFunc("/current state.json", SendJson)
	net.HandleFunc("/current state.xml", SendXML)


	// Start the server on localhost port 8080 and log any errors
	log.Println("http server started on 127.0.0.1:8080")
	_ = http.ListenAndServe(":8080", net)

}

func SendJson(w http.ResponseWriter, r *http.Request) {
	if err := r.ParseForm(); err != nil {
		fmt.Fprintf(w, "ParseForm() err: %v", err)
		return
	}

	val := r.FormValue("Relay")
	if val != "" {
		data.CurrentState.Output[0].Value = val
	}
	for  i := 1; i < 16; i++ {
		 val = r.FormValue("Relay" + strconv.Itoa(i+1))
		 if val != "" {
			 data.CurrentState.Output[i].Value = val
		 }
	}

	if data.CurrentState.Output[0].Value == "1" {
		fmt.Println("Motor3 ON")
	}
	if data.CurrentState.Output[1].Value == "1" {
		fmt.Println("Motor3 OFF")
	}
	if data.CurrentState.Output[2].Value == "1" {
		fmt.Println("Motor4 ON")
	}
	if data.CurrentState.Output[3].Value == "1" {
		fmt.Println("Motor4 OFF")
	}
	if data.CurrentState.Output[4].Value == "1" {
		fmt.Println("Motor5 ON")
	}
	if data.CurrentState.Output[5].Value == "1" {
		fmt.Println("Motor5 OFF")
	}

	year, month, day := time.Now().Date()
	data.CurrentState.Device.Date = ( strconv.Itoa(day) + "/" +  strconv.Itoa(int(month))  + "/" + strconv.Itoa(year) )
	data.CurrentState.Device.Time = time.Now().Format("15:04")
	replyJson, err := json.Marshal(data)
	if err != nil{
		panic(err)
	}
	w.Header().Set("Content-Type","application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusOK)
	w.Write(replyJson)
	go func() {
		time.Sleep(50 * time.Millisecond)
		for i:=0; i<6; i++ {
			data.CurrentState.Output[i].Value = "0"
		}
    }()

}
func SendXML(w http.ResponseWriter, r *http.Request) {
	if err := r.ParseForm(); err != nil {
		fmt.Fprintf(w, "ParseForm() err: %v", err)
		return
	}

	for  i := 0; i < 16; i++ {
		val := r.FormValue("Relay" + strconv.Itoa(i+1))
		if val != "" {
			data.CurrentState.Output[i].Value = val
		}
	}

	year, month, day := time.Now().Date()
	data.CurrentState.Device.Date = ( strconv.Itoa(day) + "/" +  strconv.Itoa(int(month))  + "/" + strconv.Itoa(year) )
	data.CurrentState.Device.Time = time.Now().Format("15:04")
	replyXML, err := xml.Marshal(data)
	if err != nil{
		panic(err)
	}
	fmt.Println(string(replyXML))
	//w.Header().Set("Content-Type","application/xml")
	//w.WriteHeader(http.StatusOK)
	w.Write(replyXML)
	go func() {
		time.Sleep(50 * time.Millisecond)
		for i:=0; i<5; i++ {
			data.CurrentState.Output[i].Value = "0"
		}
    }()
}
