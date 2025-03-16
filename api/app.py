from flask import Flask
import pokemon_api_consumer as p_consumer
app = Flask(__name__)


@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/refresh_cache')
def refresh_cache():
    found = p_consumer.refresh_cache()
    return f'Found {found}'

@app.route('/get_cache')
def get_cache():
    return p_consumer.get_all_cache_items()

if __name__ == '__main__':
    app.run(debug=True)