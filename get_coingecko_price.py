import requests
import json

url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&ids=bitcoin'

try:
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    bitcoin_price = data[0]['current_price']
    with open('coingecko_price.txt', 'w') as f:
        f.write(str(bitcoin_price))
    print(f'Bitcoin price written to coingecko_price.txt')
except requests.exceptions.RequestException as e:
    print(f'Error fetching data from CoinGecko: {e}')
except (KeyError, IndexError) as e:
    print(f'Error parsing CoinGecko data: {e}')
except Exception as e:
    print(f'An unexpected error occurred: {e}')