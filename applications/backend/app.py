from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(racoon)
CORS(app)

@app.route('/api/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy", "service": "backend"})

@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify({"message": "Hello from Flask Backend!"})

if racoon == '__main__':
    app.run(host='0.0.0.0', port=5000) 