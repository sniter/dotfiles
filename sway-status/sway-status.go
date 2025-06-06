package main

import (
	"bufio"
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"time"
)

const (
	temperatureFormat = "temp: %s"
	disksFormat       = " disk: %s"
	disksPath         = "/home"
	cpuFormat         = " cpu: %d%%"
	cpuStatPath       = "/tmp/cpu_stat"
	memFormat         = " mem: %d%%"
	swapFormat        = " / %d%%"
	weatherFormat     = " | %s"
	weatherURL        = "https://wttr.in/Jurmala?format=%C+%t+%w"
	weatherCachePath  = "/tmp/wttr_cache"
	weatherTTL        = 1200 * time.Second
	layoutFormat      = " | %s"
	batteryFormat     = " %s"
	clockFormat       = " | %s"
	clockStyle        = "2006-01-02 15:04"
)

func getTemperature() string {
	cmd := exec.Command("sensors")
	out, err := cmd.Output()
	if err != nil {
		return "N/A"
	}

	lines := strings.SplitSeq(string(out), "\n")
	for line := range lines {
		if strings.Contains(line, "CPU") {
			fields := strings.Fields(line)
			if len(fields) >= 2 {
				return fields[1]
			}
		}
	}
	return "N/A"
}

func getDiskUsage() string {
	cmd := exec.Command("df", "-h")
	out, err := cmd.Output()
	if err != nil {
		return "N/A"
	}

	lines := strings.SplitSeq(string(out), "\n")
	for line := range lines {
		if strings.Contains(line, disksPath) {
			fields := strings.Fields(line)
			if len(fields) > 0 {
				if len(fields) >= 5 {
					return fields[4]
				} else {
					return fmt.Sprintf("??? (%d fields)", len(fields))
				}
			}
		}
	}
	return "N/A"
}

func readCPUStat() (idle, total uint64, ok bool) {
	data, err := os.ReadFile("/proc/stat")
	if err != nil {
		return
	}
	fields := strings.Fields(strings.Split(string(data), "\n")[0])
	if len(fields) < 5 {
		return
	}
	for i, v := range fields[1:] {
		val, err := strconv.ParseUint(v, 10, 64)
		if err != nil {
			continue
		}
		total += val
		if i == 3 {
			idle = val
		}
	}
	ok = true
	return
}

func getCPUUsage() int {
	idleNow, totalNow, ok := readCPUStat()
	if !ok {
		return 0
	}

	lastData, err := os.ReadFile(cpuStatPath)
	if err != nil {
		// No previous data, save current and return 0
		os.WriteFile(cpuStatPath, fmt.Appendf(nil, "%d %d", idleNow, totalNow), 0644)
		return 0
	}

	parts := strings.Fields(string(lastData))
	if len(parts) != 2 {
		os.WriteFile(cpuStatPath, fmt.Appendf(nil, "%d %d", idleNow, totalNow), 0644)
		return 0
	}

	idlePrev, _ := strconv.ParseUint(parts[0], 10, 64)
	totalPrev, _ := strconv.ParseUint(parts[1], 10, 64)

	os.WriteFile(cpuStatPath, fmt.Appendf(nil, "%d %d", idleNow, totalNow), 0644)

	totalDelta := float64(totalNow - totalPrev)
	idleDelta := float64(idleNow - idlePrev)

	if totalDelta == 0 {
		return 0
	}

	usage := 100 * (1.0 - idleDelta/totalDelta)
	return int(usage + 0.5)
}

func getMemoryUsage() int {
	data, err := os.ReadFile("/proc/meminfo")
	if err != nil {
		return 0
	}

	var memTotal, memFree int
	for line := range strings.SplitSeq(string(data), "\n") {
		if strings.HasPrefix(line, "MemTotal:") {
			fmt.Sscanf(line, "MemTotal: %d kB", &memTotal)
		} else if strings.HasPrefix(line, "MemFree:") {
			fmt.Sscanf(line, "MemFree: %d kB", &memFree)
		}
	}
	if memTotal == 0 {
		return 0
	}
	used := int(100 * float64(memTotal-memFree) / float64(memTotal))
	return used
}

func getSwapUsage() int {
	data, err := os.ReadFile("/proc/meminfo")
	if err != nil {
		return 0
	}

	var swapTotal, swapFree int
	for line := range strings.SplitSeq(string(data), "\n") {
		if strings.HasPrefix(line, "SwapTotal:") {
			fmt.Sscanf(line, "SwapTotal: %d kB", &swapTotal)
		} else if strings.HasPrefix(line, "SwapFree:") {
			fmt.Sscanf(line, "SwapFree: %d kB", &swapFree)
		}
	}
	if swapTotal == 0 {
		return 0
	}
	used := int(100 * float64(swapTotal-swapFree) / float64(swapTotal))
	return used
}

func getWeather() string {
	info, err := os.Stat(weatherCachePath)
	if err == nil && time.Since(info.ModTime()) < weatherTTL {
		if data, err := os.ReadFile(weatherCachePath); err == nil {
			return string(data)
		}
	}

	resp, err := http.Get(weatherURL)
	if err != nil {
		return "N/A"
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "N/A"
	}
	_ = os.WriteFile(weatherCachePath, body, 0644)
	return string(body)
}

func getLayout() string {
	cmd := exec.Command("swaymsg", "-t", "get_inputs")
	out, err := cmd.Output()
	if err != nil {
		return "N/A"
	}

	scanner := bufio.NewScanner(strings.NewReader(string(out)))
	for scanner.Scan() {
		line := scanner.Text()
		if strings.Contains(line, "xkb_active_layout_name") {
			var layout string
			fmt.Sscanf(line, "\t\t\"xkb_active_layout_name\": \"%s", &layout)
			layout = strings.TrimSuffix(layout, "\",")

			switch {
			case strings.HasPrefix(layout, "Rus"):
				return "RU"
			case strings.HasPrefix(layout, "Latv"):
				return "LV"
			case strings.HasPrefix(layout, "Eng"):
				return "EN"
			default:
				if len(layout) >= 2 {
					return layout[:2]
				}
				return layout
			}
		}
	}
	return "N/A?"
}

func getBattery() string {
	capacityPath := "/sys/class/power_supply/BAT0/capacity"
	statusPath := "/sys/class/power_supply/BAT0/status"

	capacityData, err := os.ReadFile(capacityPath)
	if err != nil {
		return "N/A"
	}
	statusData, err := os.ReadFile(statusPath)
	if err != nil {
		return "N/A"
	}

	capacityStr := strings.TrimSpace(string(capacityData))
	capacityVal, err := strconv.Atoi(capacityStr)
	if err != nil {
		return fmt.Sprintf("??? %s", capacityStr)
	}

	statusStr := strings.TrimSpace(string(statusData))

	icons := []string{"󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"}
	iconIdx := capacityVal / 10
	if iconIdx >= len(icons) {
		iconIdx = len(icons) - 1
	}

	statusIcon := ""
	switch statusStr {
	case "Charging":
		statusIcon = ""
	case "Full":
		statusIcon = ""
	case "Not charging":
		statusIcon = ""
	case "Discharging":
		statusIcon = ""
	default:
		statusIcon = statusStr
	}

	return fmt.Sprintf("%s%s %d%%", statusIcon, icons[iconIdx], capacityVal)
}

func getClock() string {
	return time.Now().Format(clockStyle)
}

func main() {
	temp := fmt.Sprintf(temperatureFormat, getTemperature())
	diskUsage := fmt.Sprintf(disksFormat, getDiskUsage())
	cpuUsage := fmt.Sprintf(cpuFormat, getCPUUsage())
	memoryUsage := fmt.Sprintf(memFormat, getMemoryUsage())
	swapUsage := fmt.Sprintf(swapFormat, getSwapUsage())
	weather := fmt.Sprintf(weatherFormat, getWeather())
	layout := fmt.Sprintf(layoutFormat, getLayout())
	battery := fmt.Sprintf(batteryFormat, getBattery())
	clock := fmt.Sprintf(clockFormat, getClock())

	fmt.Println(temp + diskUsage + cpuUsage + memoryUsage + swapUsage + weather + layout + battery + clock)
}
