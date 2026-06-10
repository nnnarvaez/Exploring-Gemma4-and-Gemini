# These are instructions to install honcho self hosted not containerized
Fine tuned with instructions from here https://honcho.dev/docs/v2/contributing/self-hosting (Meaning this is the direct translation to what worked)

*WARNING*: Honcho is heavy in inference, if it has backlog it will monopolize your endpoint, be adviced you should let it clear its backlog. Dont use it with a smaller model on the same endpoint in router mode, it will constantly kick the main model out to do its honching... I let it use the same main model and this works.


### Local Environment Setup

By the end of this guide, you’ll have:

- A local Honcho server running on your machine
- A PostgreSQL database with pgvector extension
- Basic configuration to connect your applications
- A working environment for development or testing
- No docker not other millenial bullshit. 

---
Step 1: play soothing music, you will need it...

Make the folder, clone etc

```
git clone https://github.com/plastic-labs/honcho.git
cd honcho
uv sync
source honcho/.venv/bin/activate
```

If you need to install Postgreql and or pgvector

```
sudo apt update
sudo apt install postgresql postgresql-contrib
# Install pgvector extension (see pgvector docs for your version)
sudo apt install postgresql-18-pgvector
```

DB setup
```
# Connect to PostgreSQL and enable extensions on the default database 
sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS vector; CREATE EXTENSION IF NOT EXISTS pg_trgm;"
```

Maybe change the password if you want
```
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'a-password-here';"

```

Copy the massive template prefilled with paying API services to our .env file (we will clean it later)
```
cp .env.template .env
```

Edit the `.env ` to reflect the password 

`DB_CONNECTION_URI=postgresql+psycopg://postgres:a-password-here@localhost:5432/postgres`

or use `127.0.0.1` in some enviroments localhost will not be cooperative


I dont know what this does but the docs say you need to run it

```
uv run alembic upgrade head
```

Time to start the server
```
# Start the development server
fastapi dev src/main.py
```

I changed my port you can do too
```
# Change the port if you like so
fastapi dev src/main.py --port 8082

```


That should run in the background

Create the file
```
sudo nano /etc/systemd/system/honcho.service
```

Paste this (use your user name !!!!)
```
# Add this to the file and save it / exit
[Unit]
Description=Honcho Self-Hosted Backend Service
After=network.target postgresql.service

[Service]
User=your-nix-user
WorkingDirectory=/home/your-nix-user/honcho
EnvironmentFile=/home/your-nix-user/honcho/.env
ExecStart=/home/your-nix-user/honcho/.venv/bin/fastapi run src/main.py --port 8082
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Do linux Adminii stuff
```
# Enable and Start the Background Service
sudo systemctl daemon-reload
sudo systemctl enable honcho.service
sudo systemctl start honcho.service
```

More linux savant checks...
```
# Check the status
sudo systemctl status honcho.service


# Watch the logs... if you want... 
journalctl -u honcho.service -f
```


The fuckers want you to pay for an API but we are local babe
Edit the `.env` to redirect everything to local inference (dont let them scam you) 

```
nano ~/honcho/.env
```


# Find and adapt
```
# Tell Honcho to use an OpenAI-compatible local server
LLM_DEFAULT_PROVIDER=openai
OPENAI_BASE_URL=http://192.168.1.240:8080/v1  # Replace with your actual model server port
OPENAI_API_KEY=

# Tell Honcho which specific local model to call for reasoning
DIALECTIC_MODEL=Gemma4-12B-Q6KP-Harness  # Ensure this exact string matches your local model tag
```

```
# Tell Honcho to use an OpenAI-compatible local server

LLM_DEFAULT_PROVIDER=openai
DERIVER_MODEL_CONFIG__OVERRIDES__BASE_URL=http://192.168.1.240:8080/v1 
DERIVER_MODEL_CONFIG__TRANSPORT=openai
DERIVER_MODEL_CONFIG__MODEL=Gemma4-12B-Q6KP-Harness
LLM_OPENAI_API_KEY= none-fuck-off
OPENAI_BASE_URL=http://192.168.1.240:8080/v1  # Replace with your actual model server port
# Tell Honcho which specific local model to call for reasoning
DIALECTIC_MODEL=Gemma4-12B-Q6KP-Harness  # Ensure this exact string matches your local model tag
```

# The .env template is a mess all comented and with predefined several inference providers maybe as illustrative examples you need to clear that mess some values are commented but stupid honcho expects them to be defined and fail

*PS:* The more i try, the more i hate AI

Have fun honching... 
