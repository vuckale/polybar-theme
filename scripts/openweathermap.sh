#!/bin/env sh
get_icon() {
    case $1 in
        01d) icon="";;
        01n) icon="󰖔";;
        02d) icon="󰖕";;
        02n) icon="󰼱";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="󰖑";;
        50n) icon="";;
        *) icon="";
    esac
    echo $icon
}

KEY="$(echo $OPEN_WEATHER_API_KEY)"
CITY="$(echo "id=$OPEN_WEATHER_CITY_ID")"
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"
weather=$(curl -s "$API/weather?appid=$KEY&$CITY&units=$UNITS")

weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
echo "$(get_icon "$weather_icon")" "$weather_temp$SYMBOL"

