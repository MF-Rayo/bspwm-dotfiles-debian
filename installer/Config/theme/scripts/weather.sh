#!/bin/bash

CITY=$(jq -r '.city' "$HOME/.config/theme/config.json")
API_KEY=$(jq -r '.api.openweather' "$HOME/.config/theme/config.json")

if [[ $API_KEY = "" ]]; then 
  echo ""
  exit 0
fi
WEATHER=$(curl -s "https://api.openweathermap.org/data/2.5/weather?q=${CITY}&units=metric&appid=${API_KEY}")

TEMP=$(echo "$WEATHER" | jq ".main.temp" | xargs printf "%.0f")
ICON_CODE=$(echo "$WEATHER" | jq -r ".weather[0].icon")

case "$ICON_CODE" in
  01d) ICON="󰖙" ;; # despejado día
  01n) ICON="󰖔" ;; # despejado noche

  02d) ICON="󰖕" ;; # pocas nubes día
  02n) ICON="󰖖" ;; # pocas nubes noche

  03d|03n) ICON="󰖐" ;; # nublado
  04d|04n) ICON="󰖐" ;; # muy nublado

  09d|09n) ICON="󰖗" ;; # lluvia ligera
  10d) ICON="󰖘" ;;     # lluvia día
  10n) ICON="󰖘" ;;     # lluvia noche

  11d|11n) ICON="󰖓" ;; # tormenta
  13d|13n) ICON="󰖚" ;; # nieve
  50d|50n) ICON="󰖑" ;; # niebla

  *) ICON="󰖒" ;;       # desconocido
esac

echo "${ICON} ${TEMP}°C"
