#!/bin/bash
set -e

# Update system packages
apt-get update
apt-get upgrade -y

# Install Python and pip
apt-get install -y python3 python3-pip

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs

# Install Git
apt-get install -y git

# Create app directory
mkdir -p /app
cd /app

# Clone the application repository (you'll need to replace this with your actual repository)
git clone https://github.com/yourusername/your-repo.git .

# Setup backend
cd /app/backend
pip3 install -r requirements.txt

# Create systemd service for Flask backend
cat > /etc/systemd/system/flask-backend.service << 'EOF'
[Unit]
Description=Flask Backend Service
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/app/backend
Environment=FLASK_APP=app.py
Environment=FLASK_ENV=production
ExecStart=/usr/bin/python3 -m flask run --host=0.0.0.0 --port=5000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Setup frontend
cd /app/frontend
npm install

# Create systemd service for Express frontend
cat > /etc/systemd/system/express-frontend.service << 'EOF'
[Unit]
Description=Express Frontend Service
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/app/frontend
Environment=PORT=3000
Environment=BACKEND_URL=http://localhost:5000
ExecStart=/usr/bin/npm start
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Start services
systemctl daemon-reload
systemctl enable flask-backend
systemctl enable express-frontend
systemctl start flask-backend
systemctl start express-frontend 