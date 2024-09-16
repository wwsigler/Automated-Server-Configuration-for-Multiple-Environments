
Documentation for Bash Script and Ansible Playbooks

###Running the Bash Script###

1. Prerequisites:

Ensure Ansible is installed on your control machine.
Verify SSH access to all target servers.
Ensure Git is installed on the server where the scripts will run.

2. Script Execution:

Navigate to the directory containing the script.
Give execute permission: chmod +x scriptname.sh.
Run the script: ./scriptname.sh.

###Configuring Cron Jobs###

1. Editing Crontab:

Open crontab for editing: crontab -e.
Add cron jobs in the format: * * * * * /path/to/script/scriptname.sh.
Replace the path with the actual script location.
Adjust the cron timing (e.g., * * * * * for every minute).

###Updating Server Environment Using Ansible Playbooks###

1. Playbook Location:

Ensure all playbooks are stored in a specified directory.

2. Manual Playbook Execution:

Navigate to the playbook directory.
Run: ansible-playbook playbookname.yml.
Replace playbookname.yml with the desired playbook.

###Configuring Git Repository for Web Application Deployment###

1. SSH Key Setup:

Ensure SSH keys are configured for Git access without interactive authentication.

2. Repository Configuration:

Clone the repository manually once on the server to avoid SSH authenticity prompts.
Use appropriate branch for each environment in the deployment scripts.

###Troubleshooting Steps and Common Issues###

1. Script Execution Failure:

Ensure execution permission on the script.
Verify correct paths to Ansible playbooks.
Confirm user executing script has necessary permissions.

2. Ansible Playbook Errors:

Check SSH connectivity to target servers.
Ensure required software (Ansible, Git) is installed on control machine.
Check for syntax errors in playbooks.

3. Cron Job Not Executing:

Confirm cron service is active.
Check cron job syntax and timing.
Review cron logs for errors.

4. Git Clone Issues:

Confirm SSH key access to the repository.
Verify the correct repository URL in playbooks.

5. Package Update Issues:

Check network connectivity.
Verify correct package names in playbooks.
