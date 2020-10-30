#!/usr/bin/env python3
from bs4 import BeautifulSoup
import requests
import datetime
url = ""
	
if not url:
	print('url not specified: visit https://weather.com/en-GB/, enter your destination and pate url in \'url\' variable')
else:
		html_doc = requests.get(url).text
		soup = BeautifulSoup(html_doc, 'html.parser')

		sunrise_sunset = soup.find("div", {"class" : "SunriseSunset--datesContainer--3YG_Q"})
		sunrise = sunrise_sunset.find("div" , {"data-testid" : "SunriseValue"}).p.string
		sunset = sunrise_sunset.find("div" , {"data-testid" : "SunsetValue"}).p.string
		sunrise_split = sunrise.split(':')
		sunrise_dateTime = (datetime.datetime.now()).replace(hour=int(sunrise_split[0]), minute=int(sunrise_split[1]))
		sunset_split = sunset.split(':')
		sunset_dateTime = (datetime.datetime.now()).replace(hour=int(sunset_split[0]), minute=(int(sunset_split[1])))
		current_dateTime = datetime.datetime.now()
		
		def sunIsUp():
			if (current_dateTime <= sunset_dateTime and current_dateTime >= sunrise_dateTime):
				return True

			else:
				return False

		options = {
			'Sunny' : '',
			'Mostly Sunny' : '',
			'Partly Sunny' : '',
			
			'Cloudy' : '',
			'Partly Cloudy' : '' if sunIsUp() else '󰼱',
			'Mostly Cloudy' : '',
			
			'Fair' : '' if sunIsUp() else '󰼱',
			'Clear' : '' if sunIsUp() else '󰖔',
			'Fog' : '󰖑',
			'Showers' : '',
			'T-Storms' : '',
			'Rain' : '',
			'Snow' : '',
			'Windy':'' 
		}

		currentWeather = soup.find("div", { "class" : "CurrentConditions--primary--3xWnK" })
		temperature = currentWeather.span.string
		weather_condition = currentWeather.div.string

		print(options[weather_condition] + ' ' + temperature + 'C')

