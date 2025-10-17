# File Locker Script

## A simple bash script to encrypt and decrypt files using OpenSSL with AES-256-CBC encryption.

### Usage
```bash
git clone https://github.com/Git-Cat-21/Locker
cd Locker

chmod +x locker.sh
sudo cp ./locker.sh /usr/local/bin/locker

or in WSL

cd Locker
chmod +x locker.sh
./locker.sh

```

### To view help
```bash
locker
```


## Extra Added Features
An option to let the user choose a custom output folder.

Before encrypting ask the user if they want to save the encrypted file in a different location.
If yes, prompt them to enter the full folder path.
If no, save the encrypted file in the current directory.


## Warning
Always remember your password! If you forget it, there is no way to recover your encrypted files.
After encrypting the file in a different directory, during decryption remember to keep the encrypted file in the same directory because unlike encryption you'll not have a prompt to find the encrypted file in other directory during decryption or in easy words if you've created a new directory during encryption, ctrl+x the .enc file and paste it outside the new directory created and inside the Locker directory and then delete that new directory formed.
