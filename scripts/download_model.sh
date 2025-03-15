#!/bin/bash

# Start Ollama in the background
/bin/ollama serve &
pid=$!

# Check if the server has started
echo "⏳ Waiting for the Ollama server to start..."
while ! curl -s http://localhost:11434 > /dev/null; do
    sleep 2
    echo "⏳ Server is not ready yet, waiting..."
done
echo "🟢 Ollama server is up and running!"

# Load models from the MODEL_NAMES environment variable
if [ -n "$MODEL_NAMES" ]; then
    echo "🔴 Starting to load models: $MODEL_NAMES..."
    for model in $MODEL_NAMES; do
        echo "🔄 Loading model $model..."
        ollama pull "$model"
        if [ $? -eq 0 ]; then
            echo "🟢 Model $model loaded successfully!"
        else
            echo "🔴 Error loading model $model."
        fi
    done
else
    echo "⚠️ MODEL_NAMES variable is not set, skipping model loading."
fi

# Wait for the background Ollama process to finish
wait $pid