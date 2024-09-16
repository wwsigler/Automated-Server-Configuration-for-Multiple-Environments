#!/bin/bash

# Variables
LOG_FILE="setup_deployment.log"
ANSIBLE_PLAYBOOK_DIR="/path/to/ansible/playbooks"
WEB_APP_DEPLOY_SCRIPT="/path/to/deploy_web_app.sh"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> "$LOG_FILE"
}

# Function for error handling
error_exit() {
    log "$1"
    exit 1
}

# Prompt user for environment selection
read -p "Enter the environment (Dev, Test, Prod): " ENVIRONMENT
case $ENVIRONMENT in
    Dev|Test|Prod)
        log "Selected environment: $ENVIRONMENT"
        ;;
    *)
        error_exit "Invalid environment selection. Exiting."
        ;;
esac

# Set Git branch based on environment
GIT_BRANCH=""
case $ENVIRONMENT in
    Dev)
        GIT_BRANCH="dev-branch"
        ;;
    Test)
        GIT_BRANCH="test-branch"
        ;;
    Prod)
        GIT_BRANCH="prod-branch"
        ;;
esac

# Running Ansible playbook for environment setup
ANSIBLE_PLAYBOOK="${ANSIBLE_PLAYBOOK_DIR}/${ENVIRONMENT}_setup.yml"
if [ -f "$ANSIBLE_PLAYBOOK" ]; then
    ansible-playbook "$ANSIBLE_PLAYBOOK" &>> "$LOG_FILE" || error_exit "Ansible playbook execution for environment setup failed."
    log "Ansible playbook for $ENVIRONMENT environment setup executed successfully."
else
    error_exit "Ansible playbook for $ENVIRONMENT environment setup not found."
fi

# Deploying web application
if [ -x "$WEB_APP_DEPLOY_SCRIPT" ]; then
    "$WEB_APP_DEPLOY_SCRIPT" $GIT_BRANCH &>> "$LOG_FILE" || error_exit "Web application deployment script execution failed."
    log "Web application deployment script executed successfully."
else
    error_exit "Web application deployment script not found or not executable."
fi

log "Script execution for $ENVIRONMENT environment completed successfully."
