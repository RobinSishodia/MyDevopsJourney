#!/bin/bash

# Script to automate user management and system backups

# Function to add a user
add_user() {
    echo "Enter username to add:"
    read username
    sudo useradd -m "$username"
    echo "User $username added successfully!"
}

# Function to modify a user
modify_user() {
    echo "Enter username to modify:"
    read username
    echo "Enter new password for the user:"
    sudo passwd "$username"
    echo "User $username modified successfully!"
}

# Function to delete a user
delete_user() {
    echo "Enter username to delete:"
    read username
    sudo userdel -r "$username"
    echo "User $username deleted successfully!"
}

# Function to perform system backup
backup_system() {
    echo "Starting backup process..."
    backup_dir="/backup"   # Define your backup directory
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_file="$backup_dir/system_backup_$timestamp.tar.gz"

    # Define directories to backup
    dirs_to_backup="/home /etc /var/log"

    sudo tar -czvf "$backup_file" $dirs_to_backup
    echo "Backup completed successfully! Backup saved at $backup_file"
    
    # Email notification (ensure mail is configured on the system)
    echo "Backup completed: $backup_file" | mail -s "Backup Notification" user@example.com
}

# Function to show menu
show_menu() {
    echo "--------------------------"
    echo " User Management & Backup "
    echo "--------------------------"
    echo "1. Add a user"
    echo "2. Modify a user"
    echo "3. Delete a user"
    echo "4. Backup system"
    echo "5. Exit"
    echo "--------------------------"
    echo "Enter your choice: "
}

# Main script loop
while true; do
    show_menu
    read choice

    case $choice in
        1) add_user ;;
        2) modify_user ;;
        3) delete_user ;;
        4) backup_system ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice! Please choose again." ;;
    esac
done
