#!/bin/bash

NAME="hello_world"                                # Name of the application
SOCKFILE=/var/www/hello_world/run/gunicorn.sock   # we will communicte using this unix socket
USER=gunicorn                                        # the user to run as
GROUP=webapps                                     # the group to run as
NUM_WORKERS=3                                     # how many worker processes should Gunicorn spawn
DJANGO_SETTINGS_MODULE=hello.settings             # which settings file should Django use
DJANGO_WSGI_MODULE=hello.wsgi                     # WSGI module name

echo "Starting $NAME as 'whoami'"

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

cd /var/www/hello_world/app/

# Start your Unicorn
exec gunicorn wsgi:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --log-level=debug \
  --log-file=-
