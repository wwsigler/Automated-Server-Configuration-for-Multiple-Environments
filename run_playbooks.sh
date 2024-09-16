#!/bin/bash


# Variables
ANSIBLE_PLAYBOOK_DIR="/path/to/ansible/playbooks"
LOG_FILE="cron_setup.log"
CRON_FILE="/tmp/cronjobs"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> "$LOG_FILE"
}

# Function to set up cron jobs
setup_cron() {
    local environment=$1
    local playbook=$2
    local schedule=$3

    # Check if the cron job already exists
    if ! crontab -l | grep -Fq "$playbook"; then
        # Add cron job to temporary file
        echo "$schedule /bin/bash -c 'ansible-playbook $ANSIBLE_PLAYBOOK_DIR/$playbook.yml &>> $LOG_FILE'" >> "$CRON_FILE"
        log "Scheduled cron job for $environment environment"
    else
        log "Cron job for $environment environment already exists"
    fi
}

# Create a temporary file for cron jobs
crontab -l > "$CRON_FILE"

# Schedule cron jobs for each environment
setup_cron "Dev" "dev_setup" "* * * * *"
setup_cron "Test" "test_setup" "* * * * *"
setup_cron "Prod" "prod_setup" "* * * * *"

# Schedule cron job for package updates
PACKAGE_UPDATE_PLAYBOOK="update_packages"
PACKAGE_UPDATE_SCHEDULE="0 0 * * *"
if ! crontab -l | grep -Fq "$PACKAGE_UPDATE_PLAYBOOK"; then
    echo "$PACKAGE_UPDATE_SCHEDULE /bin/bash -c 'ansible-playbook $ANSIBLE_PLAYBOOK_DIR/$PACKAGE_UPDATE_PLAYBOOK.yml &>> $LOG_FILE'" >> "$CRON_FILE"
    log "Scheduled cron job for package updates"
else
    log "Cron job for package updates already exists"
fi

# Install new cron jobs
crontab "$CRON_FILE" && rm -f "$CRON_FILE"
log "Cron jobs installation complete"

# Final log entry
log "Script execution completed successfully"
