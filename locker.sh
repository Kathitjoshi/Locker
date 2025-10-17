#!/usr/bin/bash

# Color definitions
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
BOLD='\033[1m'
RESET='\033[0m'

usage() {
    clear
    echo -e "${MAGENTA}${BOLD}"
    echo "    ╔═══════════════════════════════════════════════╗"
    echo "    ║                                               ║"
    echo -e "    ║       ${CYAN}[ FILE LOCKER TOOL ]${MAGENTA}              ║"
    echo "    ║                                               ║"
    echo -e "    ║       ${GRAY}Secure AES-256 Encryption${MAGENTA}          ║"
    echo "    ║                                               ║"
    echo "    ╚═══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo
    echo -e "${YELLOW}${BOLD}DESCRIPTION:${RESET}"
    echo -e "  ${WHITE}A simple utility to encrypt and decrypt files using OpenSSL${RESET}"
    echo -e "  ${GRAY}with military-grade AES-256-CBC encryption.${RESET}"
    echo
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
    echo -e "${CYAN}${BOLD}USAGE:${RESET}"
    echo -e "  ${WHITE}locker.sh ${BLUE}[OPTION]${RESET}"
    echo
    echo -e "${GREEN}${BOLD}OPTIONS:${RESET}"
    echo -e "  ${BLUE}-lock, -l${RESET}       ${WHITE}Encrypt a file with password protection${RESET}"
    echo -e "                  ${GRAY}→ Creates an encrypted .enc file${RESET}"
    echo
    echo -e "  ${BLUE}-unlock, -u${RESET}     ${WHITE}Decrypt a previously encrypted file${RESET}"
    echo -e "                  ${GRAY}→ Restores the original file${RESET}"
    echo
    echo -e "  ${BLUE}-h, --help${RESET}      ${WHITE}Display this help message${RESET}"
    echo
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
    echo -e "${GRAY}Examples:${RESET}"
    echo -e "  ${WHITE}$ ./locker.sh -l${RESET}     ${GRAY}# Encrypt a file${RESET}"
    echo -e "  ${WHITE}$ ./locker.sh -u${RESET}     ${GRAY}# Decrypt a file${RESET}"
    echo
}

if [[ "$1" == "-lock" || "$1" == "-l" ]]; then 
    clear
    echo -e "${CYAN}${BOLD}"
    echo "    ╔═══════════════════════════════════════════════╗"
    echo "    ║                                               ║"
    echo "    ║          [  ENCRYPTION MODE  ]                ║"
    echo "    ║                                               ║"
    echo "    ╚═══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo
    
    read -p "$(echo -e ${CYAN}[FILE]${RESET} ${WHITE}Enter the file name to encrypt: ${RESET})" file 
    echo
    
    if [[ ! -f "$file" ]]; then
        echo -e "${RED}${BOLD}[✗] ERROR:${RESET} ${RED}File not found: ${WHITE}$file${RESET}"
        echo
        exit 1
    fi
    
    # Get file size
    size=$(du -h "$file" 2>/dev/null | cut -f1)
    echo -e "${GREEN}${BOLD}[✓] SUCCESS:${RESET} ${GREEN}File located${RESET}"
    echo -e "${GRAY}    └─ File: ${WHITE}$file${RESET}"
    echo -e "${GRAY}    └─ Size: ${WHITE}$size${RESET}"
    echo
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
    echo -e "${YELLOW}${BOLD}[KEY] PASSWORD SETUP${RESET}"
    echo
    read -s -p "$(echo -e ${WHITE}Enter password: ${RESET})" password
    echo
    read -s -p "$(echo -e ${WHITE}Confirm password: ${RESET})" confirm_pass
    echo
    echo
    
    if [[ "$password" != "$confirm_pass" ]]; then
        echo -e "${RED}${BOLD}[✗] ERROR:${RESET} ${RED}Passwords do not match!${RESET}"
        echo
        exit 1
    fi
    
    if [[ ${#password} -lt 6 ]]; then
        echo -e "${YELLOW}${BOLD}[!] WARNING:${RESET} ${YELLOW}Password is short. Consider using a stronger password.${RESET}"
        echo
    fi
    
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
    echo -ne "${YELLOW}${BOLD}[⟳] ENCRYPTING${RESET} ${YELLOW}Please wait"
    for i in {1..3}; do
        sleep 0.3
        echo -n "."
    done
    echo
    echo
    
    if openssl enc -aes-256-cbc -pbkdf2 -salt \
        -pass pass:"$password" \
        -in "$file" -out "$file".enc 2>/dev/null; then
        
        rm -f "$file"
        echo -e "${GREEN}${BOLD}[✓] ENCRYPTION SUCCESSFUL${RESET}"
        echo
        echo -e "${GRAY}    ┌─ Output Details${RESET}"
        echo -e "${GRAY}    ├─ Encrypted file: ${WHITE}$file.enc${RESET}"
        echo -e "${GRAY}    ├─ Algorithm: ${WHITE}AES-256-CBC${RESET}"
        echo -e "${GRAY}    └─ Original file: ${WHITE}Securely removed${RESET}"
    else
        echo -e "${RED}${BOLD}[✗] ENCRYPTION FAILED${RESET}"
        echo -e "${RED}    └─ Please check your file and try again${RESET}"
    fi
    echo
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo

elif [[ "$1" == '-unlock' || "$1" == "-u" ]]; then
    clear
    echo -e "${CYAN}${BOLD}"
    echo "    ╔═══════════════════════════════════════════════╗"
    echo "    ║                                               ║"
    echo "    ║          [  DECRYPTION MODE  ]                ║"
    echo "    ║                                               ║"
    echo "    ╚═══════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo
    
    read -p "$(echo -e ${CYAN}[FILE]${RESET} ${WHITE}Enter filename to decrypt ${GRAY}\(without .enc\)${WHITE}: ${RESET})" file
    echo
    
    if [[ ! -f "$file.enc" ]]; then 
        echo -e "${RED}${BOLD}[✗] ERROR:${RESET} ${RED}Encrypted file not found: ${WHITE}$file.enc${RESET}"
        echo
        exit 1
    fi
    
    # Get file size
    size=$(du -h "$file.enc" 2>/dev/null | cut -f1)
    echo -e "${GREEN}${BOLD}[✓] SUCCESS:${RESET} ${GREEN}Encrypted file located${RESET}"
    echo -e "${GRAY}    └─ File: ${WHITE}$file.enc${RESET}"
    echo -e "${GRAY}    └─ Size: ${WHITE}$size${RESET}"
    echo
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
    echo -e "${YELLOW}${BOLD}[KEY] PASSWORD REQUIRED${RESET}"
    echo
    read -s -p "$(echo -e ${WHITE}Enter password: ${RESET})" password
    echo
    echo
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
    echo -ne "${YELLOW}${BOLD}[⟳] DECRYPTING${RESET} ${YELLOW}Please wait"
    for i in {1..3}; do
        sleep 0.3
        echo -n "."
    done
    echo
    echo
    
    if openssl enc -d -aes-256-cbc -pbkdf2 \
        -pass pass:"$password" \
        -in "$file".enc -out "$file" 2>/dev/null; then 
        rm -f "$file".enc
        echo -e "${GREEN}${BOLD}[✓] DECRYPTION SUCCESSFUL${RESET}"
        echo
        echo -e "${GRAY}    ┌─ Output Details${RESET}"
        echo -e "${GRAY}    ├─ Restored file: ${WHITE}$file${RESET}"
        echo -e "${GRAY}    └─ Encrypted file: ${WHITE}Removed${RESET}"
    else
        rm -f "$file"
        echo -e "${RED}${BOLD}[✗] DECRYPTION FAILED${RESET}"
        echo -e "${RED}    └─ Incorrect password or corrupted file${RESET}"
    fi
    echo
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo

elif [[ -z "$1" || "$1" == '-h' ]]; then 
    usage
else
    clear
    echo -e "${RED}${BOLD}[✗] ERROR:${RESET} ${RED}Invalid option: ${WHITE}$1${RESET}"
    echo
    echo -e "${CYAN}Use ${WHITE}-h${CYAN} or ${WHITE}--help${CYAN} for usage information${RESET}"
    echo
fi