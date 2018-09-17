base:
  '*':
    - myuser.user
    - myuser.dotfiles
  'os_family:debian':
    - match:grain
    - users_and_ssh
