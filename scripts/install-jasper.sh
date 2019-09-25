#!/bin/bash

cd /opt/install/jasperserver-ce-3.7.1-bin/buildomatic && ./js-ant create-js-db && ./js-ant init-js-db-ce && ./js-ant import-minimal-ce && ./js-ant deploy-webapp-ce



