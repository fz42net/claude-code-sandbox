FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install base packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        git \
        gnupg2 \
        ripgrep \
        zsh \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js LTS (via nodesource)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.12 and pip
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
        python3.12 \
        python3.12-dev \
        python3-pip \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages globally
RUN pip3 install --no-cache-dir --break-system-packages \
    pyyaml \
    requests \
    beautifulsoup4 \
    markdownify \
    python-frontmatter

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create vscode user if it doesn't exist
RUN if ! id -u vscode > /dev/null 2>&1; then \
        groupadd --gid 1000 vscode \
        && useradd --uid 1000 --gid vscode --shell /bin/zsh --create-home vscode; \
    fi

# Configure zsh for vscode user
RUN chsh -s /bin/zsh vscode

# Set up basic zsh configuration
RUN echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> /home/vscode/.zshrc \
    && echo 'export CLAUDE_CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"' >> /home/vscode/.zshrc

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# Set the default user
USER vscode
WORKDIR /workspace