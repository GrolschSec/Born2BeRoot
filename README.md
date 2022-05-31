# [TUTO] Born To Be Root

3 - Add an SSH Server:
    - Log as root:
    ```
    su
    ```
    - Install the SSH Server:
    ```
    apt install openssh-server
    ```
    - Enable the SSH Server at startup:
    ```
    systemctl enable ssh
    ```
