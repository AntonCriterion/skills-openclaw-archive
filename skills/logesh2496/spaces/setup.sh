#!/bin/bash

set -e

echo "🚀 Moltspaces Skill Setup"
echo "=========================="
echo ""

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "📦 Installing uv package manager..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    # Add uv to PATH for this session
    export PATH="$HOME/.cargo/bin:$PATH"
    
    echo "✅ uv installed successfully"
else
    echo "✅ uv is already installed ($(uv --version))"
fi

echo ""
echo "📚 Installing dependencies..."
uv sync

echo ""
echo "🔐 Registration Hook - Generating Agent ID..."

# Generate a unique agent ID using UUID
AGENT_ID="molt-agent-$(uuidgen | tr '[:upper:]' '[:lower:]' | cut -d'-' -f1-2)"
echo "Generated AGENT_ID: $AGENT_ID"

echo ""
echo "📡 Registering with Moltspaces API..."

# Register with the Moltspaces API
# Note: Adjust the curl command based on actual API requirements
RESPONSE=$(curl -s -X POST https://moltspaces-api-547962548252.us-central1.run.app/v1/register \
    -H "Content-Type: application/json" \
    -d "{\"agent_id\": \"$AGENT_ID\", \"skill_name\": \"moltspaces\", \"version\": \"1.0.0\"}" \
    || echo "ERROR")

# Check if registration was successful
if [[ "$RESPONSE" == *"ERROR"* ]] || [[ -z "$RESPONSE" ]]; then
    echo "⚠️  API registration endpoint may not be available"
    echo "   Continuing with local setup..."
else
    echo "✅ Registration successful"
    echo "   Response: $RESPONSE"
fi

echo ""
echo "💾 Saving configuration to .env file..."

# Create or update .env file
if [ -f .env ]; then
    # Check if MOLT_AGENT_ID already exists
    if grep -q "MOLT_AGENT_ID=" .env; then
        # Update existing value
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s/^MOLT_AGENT_ID=.*/MOLT_AGENT_ID=$AGENT_ID/" .env
        else
            sed -i "s/^MOLT_AGENT_ID=.*/MOLT_AGENT_ID=$AGENT_ID/" .env
        fi
        echo "   Updated MOLT_AGENT_ID in .env"
    else
        # Append new value
        echo "" >> .env
        echo "MOLT_AGENT_ID=$AGENT_ID" >> .env
        echo "   Added MOLT_AGENT_ID to .env"
    fi
else
    # Create new .env from example
    if [ -f env.example ]; then
        cp env.example .env
        echo "MOLT_AGENT_ID=$AGENT_ID" >> .env
        echo "   Created .env from env.example"
    else
        echo "MOLT_AGENT_ID=$AGENT_ID" > .env
        echo "   Created new .env file"
    fi
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Edit .env and add your API keys (ELEVENLABS_API_KEY, OPENAI_API_KEY, DAILY_API_KEY)"
echo "   2. Run: uv run bot.py --room <room_name>"
echo ""
echo "Your Agent ID: $AGENT_ID"
