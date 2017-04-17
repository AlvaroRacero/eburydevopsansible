# eburydevopsansible
Repository for the Ebury's Ansible test.

[![N|Solid](https://web-statics.ebury.com/wp-content/themes/ebury-master-v2/assets/img/ebury-logo.svg)](https://www.ebury.es/)

#  EBURY DEVOPS TESTS

  - ANSIBLE & AWS EXERCISE.
  - Working directory: ansible_test folder
  - Ansible version: 2.1 or higher

Create an ansible playbook that automatically deploy the following architecture in an AWS account (you can use a free AWS account to test):

1. Create a easy python application that shows "hello world!". The application code it will stored in a bitbucket account with git or mercurial.
2. Deploy two same instances t1.micro with an nginx server listening 80 port and acting as reverse proxy of python created before. The python app has to be in service through Gunicorn daemon, using supervisor for control the gunicorn.
3. In front of these two instances has to be an ELB listening ports 80. The ELB should be configured with security groups to allow request only for 80 port.
4. Configure in route53 a domain that CNAME to the ELB created before, to test that application works.
5. Generate a second ansible playbook to deploy new versions of the application, that do a pull of code in the instances and restart gunicorn process through supervisor.

### How to run
1. Install Ansible 2.1 or higher and Ansible-playbook.
2. Clone EBURY DEVOPS ANSIBLE proyect.
3. Move to the working directory.
4. Set your aws credentials on ansible_test/vars/aws-creds.yml or add it to PATH.
5. Set your bitbucket credentials on ansible_test/vars/git-creds.yml, variable gitpassword.
6. Run: 

To provision:
```sh
ansible-playbook ebury_provision_playbook.yml 
```

To update:
```sh
ansible-playbook ebury_update_playbook.yml
```

### Proyect tree

```sh
eburydevopsansible$ tree
.
├── README.md
└── ansible_test
    ├── ebury_provision_playbook.yml
    ├── ebury_update_playbook.yml
    ├── handlers
    │   └── nginx.yml
    ├── roles
    │   ├── clone_proyect_w_req
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── config_guni_nginx_supervisor
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── create_elb_add_host
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── create_instance
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── create_r53_zone
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── create_user_and_group
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── get_instances
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── install_dependencies
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── keypair
    │   │   └── tasks
    │   │       └── main.yaml
    │   ├── security_group
    │   │   └── tasks
    │   │       └── main.yaml
    │   └── update_route53_elb
    │       └── tasks
    │           └── main.yaml
    ├── templates
    │   ├── gunicorn_start.sh
    │   ├── hello.conf
    │   └── nginx.conf
    └── vars
        ├── aws-creds.yml
        └── def_vars.yml
```

### OS version

```sh
eburydevopsansible$ uname -a
Darwin AlvaroRacero.local 15.6.0 Darwin Kernel Version 15.6.0: Fri Feb 17 10:21:18 PST 2017; root:xnu-3248.60.11.4.1~1/RELEASE_X86_64 x86_64
```

```sh
eburydevopsansible$ sw_vers
ProductName:	Mac OS X
ProductVersion:	10.11.6
BuildVersion:	15G1421
```

### Ansible version

```sh
eburydevopsansible$ ansible --version
ansible 2.2.2.0
  config file = 
  configured module search path = Default w/o overrides
```

```sh
eburydevopsansible$ ansible-playbook --version
ansible-playbook 2.2.2.0
  config file = 
  configured module search path = Default w/o overrides
```