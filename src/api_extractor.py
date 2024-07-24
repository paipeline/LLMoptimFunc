 from gradio_client import Client

 client = Client("https://fingpt-fingpt-forecaster.hf.space/--replicas/me7ol/")
 result = client.predict(
         "TSLA", # str  in 'Ticker' Textbox component
         "2024-06-01",   # str  in 'Date' Textbox component
         4,  # int | float (numeric value between 1 and 4) in 'n_weeks' Slider component
         True,   # bool  in 'Use Latest Basic Financials' Checkbox component
         api_name="/predict"
 )
 
 