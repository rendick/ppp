# ppp, aka p³ - powerful password producer

**ppp** is a powerful password producer, that helps you store your passwords in a safe way.

## The reasons why I write this project

The most dominant reason I write this project is that Unix-like operating systems do not have enough lightweight CLI password managers. Many people want to store their password directly on the system (although I highly recommend to store them  on the system and in a notebook/copybook too)

## Installation

### Install the already built binary

```
curl -LO https://github.com/rendick/ppp/releases/latest/download/ppp
chmod +x ./ppp
./ppp
```

### Build from source

```
cabal clean
cabal build --ghc-options="-O2  -funbox-strict-fields -split-sections"
# If you want to optimize the binary file, you can use the strip command
strip --strip-all dist-newstyle/build/x86_64-linux/ghc-*/ppp-*/x/ppp/build/ppp/ppp

# If you want to optimize it even more, you can add the upx command to the existing commands
upx --best dist-newstyle/build/x86_64-linux/ghc-*/ppp-*/x/ppp/build/ppp/ppp
```


## What can this program do?

As I said before, ppp is a **powerful** password producer (and manager). It can generate your password using the `-g` or `--gen` arguments and at the same time calculate the entropy of the generated password. If the password is unsafe, ppp will ask you If want to continue or not. You can also check the generated (saved password) in the `~/passwd.yaml` file (I highly recommend you to give it root:root permissions using the following command: `sudo chown root:root /path/to/passwd.yaml`, `sudo chmod 600 /path/to/passwd.yaml`; ppp is able to work in root mode, so do not worry). 

If you do not want to read the whole file looking for a specific password, you can search fot it by name using the `-s` or `--search` arguments, and if you want to display a parsed YAML file, you can use `-A` or `--all-passwords` arguments.

## What I plan to impelement in the next versions?

I plan to implement code refactoring, search by password and its entropy (+tags), encryption for YAML file with passwords, tags for passwords, choice of password type (easy-to-remember and hard-to-remember), config file for the program with the ability to choose a custom path to saved passwords.

## License

[The 2-Clause BSD License](https://opensource.org/license/bsd-2-clause)
