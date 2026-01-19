# SAFE FUNCTIONS POLICY:
# - Read-only operations only
# - Context visibility helpers
# - No destructive operations
# - No context switching

# Show current Kubernetes context and namespace
kctx-info() {
    echo "Context: $(kubectl config current-context)"
    echo "Namespace: $(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || echo 'default')"
}

# Show Terraform workspace and working directory
tf-info() {
    if command -v terraform >/dev/null 2>&1; then
        echo "Workspace: $(terraform workspace show 2>/dev/null || echo 'N/A')"
        echo "Directory: $(pwd)"
    else
        echo "Terraform not found"
    fi
}

# Show Docker context (if using Docker contexts)
dctx-info() {
    if command -v docker >/dev/null 2>&1; then
        echo "Docker context: $(docker context show 2>/dev/null || echo 'default')"
    else
        echo "Docker not found"
    fi
}

# Show all context information at once
ctx-info() {
    echo "=== Context Information ==="
    if command -v kubectl >/dev/null 2>&1; then
        kctx-info
        echo ""
    fi
    if command -v terraform >/dev/null 2>&1; then
        tf-info
        echo ""
    fi
    if command -v docker >/dev/null 2>&1; then
        dctx-info
        echo ""
    fi
}

# Safe path manipulation - prepend to PATH if not already present
path-prepend() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

# Safe path manipulation - append to PATH if not already present
path-append() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}
