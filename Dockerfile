FROM jnyryan/simplesamlphp

# Fix bug
RUN chmod 777 -R /var/lib/php5

#Enable Identity Provider Functionality
RUN sed -i -e "s/'enable.saml20-idp' => false,/'enable.saml20-idp' => true,/" /var/simplesamlphp/config/config.php
RUN touch /var/simplesamlphp/modules/exampleauth/enable

#Add default users
COPY ./authsources.php /var/simplesamlphp/config/authsources.php

# Add some more config
COPY ./saml20-idp-hosted.php /var/simplesamlphp/metadata/saml20-idp-hosted.php
COPY ./saml20-sp-remote.php  /var/simplesamlphp/metadata/saml20-sp-remote.php

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
