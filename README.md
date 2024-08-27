# ppp, aka p³ - powerful password producer

**ppp** is a powerful password producer, that helps you store your passwords in a safe way.

## The reasons why I write this project

The most dominant reason I write this project is that Unix-like operating systems do not have enough lightweight CLI password managers. Many people want to store their password directly on the system (although I highly recommend to store them  on the system and in a notebook/copybook too)

## What can this program do?

As I said before, ppp is a **powerful** password producer (and manager). It can generate your password using the `-g` or `--gen` arguments and at the same time calculate the entropy of the generated password. If the password is unsafe, ppp will ask you If want to continue or not. You can also check the generated (saved password) in the `~/passwd.yaml` file (I highly recommend you to give it root:root permissions using the following command: `sudo chown root:root /path/to/passwd.yaml`; ppp is able to work in root mode, so do not worry). 
If you do not want to read the whole file looking for a specific password, you can search fot it by name using the `-s` or `--search` arguments, and if you want to display a parsed YAML file, you can use `-A` or `--all-passwords` arguments.

## License

[The 2-Clause BSD License](https://opensource.org/license/bsd-2-clause)
